enum AppThemeMode {
  light,
  dark,
  system,
}

class AppSettings {
  const AppSettings({
    required this.themeMode,
    required this.refreshFrequencyMinutes,
  });

  final AppThemeMode themeMode;
  final int refreshFrequencyMinutes;
}
