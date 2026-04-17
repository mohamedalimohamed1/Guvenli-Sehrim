import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/namaz/domain/model/prayer_models.dart';
import 'package:guvenli_sehrim/features/namaz/domain/repository/namaz_repository.dart';

class NamazProvider extends ChangeNotifier {
  NamazProvider(this.repository);

  final NamazRepository repository;

  ViewState<PrayerTimesSnapshot> _state = const ViewState.initial();

  ViewState<PrayerTimesSnapshot> get state => _state;

  Future<void> load() async {
    _state = ViewState.loading(
      previousData: _state.data,
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();

    final result = await repository.getPrayerTimes();
    _state = _mapResult(result);
    notifyListeners();
  }

  Future<void> refresh() => load();

  ViewState<PrayerTimesSnapshot> _mapResult(
    Result<RepositoryData<PrayerTimesSnapshot>> result,
  ) {
    if (result is ResultFailure<RepositoryData<PrayerTimesSnapshot>>) {
      return ViewState.error(
        result.failure,
        previousData: _state.data,
        lastUpdated: _state.lastUpdated,
        isOffline: _state.isOffline,
      );
    }

    final payload =
        (result as ResultSuccess<RepositoryData<PrayerTimesSnapshot>>).data;
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
