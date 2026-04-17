import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';

class SettingsSnapshotDto {
  const SettingsSnapshotDto({
    required this.themePreference,
    required this.earthquakeThreshold,
    required this.aqiThreshold,
    required this.refreshIntervalMinutes,
    required this.notificationsEnabled,
    required this.cacheSizeMb,
    required this.availableIntervals,
  });

  final ThemePreference themePreference;
  final double earthquakeThreshold;
  final int aqiThreshold;
  final int refreshIntervalMinutes;
  final bool notificationsEnabled;
  final double cacheSizeMb;
  final List<int> availableIntervals;

  factory SettingsSnapshotDto.fromJson(Map<String, dynamic> json) {
    final notifications =
        json['bildirimler'] as Map<String, dynamic>? ?? const {};
    final data = json['veri'] as Map<String, dynamic>? ?? const {};
    return SettingsSnapshotDto(
      themePreference: _parseTheme(json['tema'] as String? ?? 'system'),
      earthquakeThreshold: (notifications['depremEsik'] as num? ?? 0).toDouble(),
      aqiThreshold: notifications['aqiEsik'] as int? ?? 0,
      refreshIntervalMinutes: data['yenilemeDakika'] as int? ?? 15,
      notificationsEnabled: notifications['aktif'] as bool? ?? false,
      cacheSizeMb: (data['cacheMb'] as num? ?? 0).toDouble(),
      availableIntervals: (data['secenekler'] as List<dynamic>? ?? const [])
          .cast<int>()
          .toList(growable: false),
    );
  }

  SettingsSnapshot toDomain() {
    return SettingsSnapshot(
      themePreference: themePreference,
      earthquakeThreshold: earthquakeThreshold,
      aqiThreshold: aqiThreshold,
      refreshIntervalMinutes: refreshIntervalMinutes,
      notificationsEnabled: notificationsEnabled,
      cacheSizeMb: cacheSizeMb,
      availableIntervals: availableIntervals,
    );
  }

  static ThemePreference _parseTheme(String value) {
    switch (value) {
      case 'light':
        return ThemePreference.light;
      case 'dark':
        return ThemePreference.dark;
      default:
        return ThemePreference.system;
    }
  }
}
