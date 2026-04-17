import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';
import 'package:guvenli_sehrim/features/doviz/domain/repository/doviz_repository.dart';

class DovizProvider extends ChangeNotifier {
  DovizProvider(this.repository);

  final DovizRepository repository;

  ViewState<MarketsSnapshot> _state = const ViewState.initial();

  ViewState<MarketsSnapshot> get state => _state;

  Future<void> load() async {
    _state = ViewState.loading(
      previousData: _state.data,
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();

    final result = await repository.getMarketsSnapshot();
    _state = _mapResult(result);
    notifyListeners();
  }

  Future<void> refresh() => load();

  void toggleFavorite(String code) {
    if (_state.data == null) return;
    
    final current = _state.data!;
    final updatedQuotes = current.allQuotes.map((item) {
      if (item.code == code) {
        return MarketQuote(
          code: item.code,
          name: item.name,
          buyPrice: item.buyPrice,
          sellPrice: item.sellPrice,
          dailyChangePercent: item.dailyChangePercent,
          isFavorite: !item.isFavorite,
        );
      }
      return item;
    }).toList();

    _state = ViewState.success(
      MarketsSnapshot(
        lastUpdatedLabel: current.lastUpdatedLabel,
        highlights: current.highlights,
        allQuotes: updatedQuotes,
        trend: current.trend,
      ),
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  ViewState<MarketsSnapshot> _mapResult(
    Result<RepositoryData<MarketsSnapshot>> result,
  ) {
    if (result is ResultFailure<RepositoryData<MarketsSnapshot>>) {
      return ViewState.error(
        result.failure,
        previousData: _state.data,
        lastUpdated: _state.lastUpdated,
        isOffline: _state.isOffline,
      );
    }

    final payload = (result as ResultSuccess<RepositoryData<MarketsSnapshot>>).data;
    if (payload.isEmpty) {
      return ViewState.empty(
        previousData: payload.data,
        lastUpdated: payload.lastUpdated,
        isOffline: payload.isFromCache,
      );
    }

    return ViewState.success(
      payload.data,
      lastUpdated: payload.lastUpdated,
      isOffline: payload.isFromCache,
    );
  }
}
