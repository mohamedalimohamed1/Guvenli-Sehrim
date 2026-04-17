enum ThemePreference {
  light,
  dark,
  system,
}

class SettingsSnapshot {
  const SettingsSnapshot({
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
}
