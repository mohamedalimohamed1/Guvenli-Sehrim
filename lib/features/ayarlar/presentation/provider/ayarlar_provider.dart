import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/repository/ayarlar_repository.dart';

class AyarlarProvider extends ChangeNotifier {
  AyarlarProvider(this.repository);

  final AyarlarRepository repository;

  ViewState<SettingsSnapshot> _state = const ViewState.initial();

  ViewState<SettingsSnapshot> get state => _state;

  Future<void> load() async {
    _state = ViewState.loading(
      previousData: _state.data,
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();

    final result = await repository.getSettings();
    _state = _mapResult(result);
    notifyListeners();
  }

  Future<void> refresh() => load();

  void updateThemePreference(ThemePreference preference) {
    final data = _state.data;
    if (data == null) return;
    _state = ViewState.success(
      SettingsSnapshot(
        themePreference: preference,
        earthquakeThreshold: data.earthquakeThreshold,
        aqiThreshold: data.aqiThreshold,
        refreshIntervalMinutes: data.refreshIntervalMinutes,
        notificationsEnabled: data.notificationsEnabled,
        cacheSizeMb: data.cacheSizeMb,
        availableIntervals: data.availableIntervals,
      ),
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  void updateEarthquakeThreshold(double value) {
    final data = _state.data;
    if (data == null) return;
    _state = ViewState.success(
      SettingsSnapshot(
        themePreference: data.themePreference,
        earthquakeThreshold: value,
        aqiThreshold: data.aqiThreshold,
        refreshIntervalMinutes: data.refreshIntervalMinutes,
        notificationsEnabled: data.notificationsEnabled,
        cacheSizeMb: data.cacheSizeMb,
        availableIntervals: data.availableIntervals,
      ),
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  void updateAqiThreshold(int value) {
    final data = _state.data;
    if (data == null) return;
    _state = ViewState.success(
      SettingsSnapshot(
        themePreference: data.themePreference,
        earthquakeThreshold: data.earthquakeThreshold,
        aqiThreshold: value,
        refreshIntervalMinutes: data.refreshIntervalMinutes,
        notificationsEnabled: data.notificationsEnabled,
        cacheSizeMb: data.cacheSizeMb,
        availableIntervals: data.availableIntervals,
      ),
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  void updateRefreshInterval(int minutes) {
    final data = _state.data;
    if (data == null) return;
    _state = ViewState.success(
      SettingsSnapshot(
        themePreference: data.themePreference,
        earthquakeThreshold: data.earthquakeThreshold,
        aqiThreshold: data.aqiThreshold,
        refreshIntervalMinutes: minutes,
        notificationsEnabled: data.notificationsEnabled,
        cacheSizeMb: data.cacheSizeMb,
        availableIntervals: data.availableIntervals,
      ),
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  void clearCache() {
    final data = _state.data;
    if (data == null) return;
    _state = ViewState.success(
      SettingsSnapshot(
        themePreference: data.themePreference,
        earthquakeThreshold: data.earthquakeThreshold,
        aqiThreshold: data.aqiThreshold,
        refreshIntervalMinutes: data.refreshIntervalMinutes,
        notificationsEnabled: data.notificationsEnabled,
        cacheSizeMb: 0,
        availableIntervals: data.availableIntervals,
      ),
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();
  }

  ViewState<SettingsSnapshot> _mapResult(
    Result<RepositoryData<SettingsSnapshot>> result,
  ) {
    if (result is ResultFailure<RepositoryData<SettingsSnapshot>>) {
      return ViewState.error(
        result.failure,
        previousData: _state.data,
        lastUpdated: _state.lastUpdated,
        isOffline: _state.isOffline,
      );
    }

    final payload = (result as ResultSuccess<RepositoryData<SettingsSnapshot>>).data;
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
