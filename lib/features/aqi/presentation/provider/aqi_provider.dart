import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';
import 'package:guvenli_sehrim/features/aqi/domain/repository/aqi_repository.dart';

class AqiProvider extends ChangeNotifier {
  AqiProvider(this.repository);

  final AqiRepository repository;

  ViewState<AirQualitySnapshot> _state = const ViewState.initial();

  ViewState<AirQualitySnapshot> get state => _state;

  Future<void> load() async {
    _state = ViewState.loading(
      previousData: _state.data,
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();

    final result = await repository.getAqiSnapshot();
    _state = _mapResult(result);
    notifyListeners();
  }

  Future<void> refresh() => load();

  ViewState<AirQualitySnapshot> _mapResult(
    Result<RepositoryData<AirQualitySnapshot>> result,
  ) {
    if (result is ResultFailure<RepositoryData<AirQualitySnapshot>>) {
      return ViewState.error(
        result.failure,
        previousData: _state.data,
        lastUpdated: _state.lastUpdated,
        isOffline: _state.isOffline,
      );
    }

    final payload = (result as ResultSuccess<RepositoryData<AirQualitySnapshot>>).data;
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
