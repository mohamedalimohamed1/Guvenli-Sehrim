import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';
import 'package:guvenli_sehrim/features/hava/domain/repository/hava_repository.dart';

class HavaProvider extends ChangeNotifier {
  HavaProvider(this.repository);

  final HavaRepository repository;

  ViewState<WeatherSnapshot> _state = const ViewState.initial();

  ViewState<WeatherSnapshot> get state => _state;

  Future<void> load() async {
    _state = ViewState.loading(
      previousData: _state.data,
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();

    final result = await repository.getWeatherSnapshot();
    _state = _mapResult(result);
    notifyListeners();
  }

  Future<void> refresh() => load();

  ViewState<WeatherSnapshot> _mapResult(
    Result<RepositoryData<WeatherSnapshot>> result,
  ) {
    if (result is ResultFailure<RepositoryData<WeatherSnapshot>>) {
      return ViewState.error(
        result.failure,
        previousData: _state.data,
        lastUpdated: _state.lastUpdated,
        isOffline: _state.isOffline,
      );
    }

    final payload = (result as ResultSuccess<RepositoryData<WeatherSnapshot>>).data;
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
