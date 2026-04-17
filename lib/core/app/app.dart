import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/app/app_dependencies.dart';
import 'package:guvenli_sehrim/core/app/app_shell.dart';
import 'package:guvenli_sehrim/core/routing/app_router.dart';
import 'package:guvenli_sehrim/core/theme/app_theme.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';

class GuvenliSehrimApp extends StatefulWidget {
  const GuvenliSehrimApp({super.key});

  @override
  State<GuvenliSehrimApp> createState() => _GuvenliSehrimAppState();
}

class _GuvenliSehrimAppState extends State<GuvenliSehrimApp> {
  late final AppDependencies _dependencies;

  @override
  void initState() {
    super.initState();
    _dependencies = AppDependencies.mock();
    Future.microtask(_dependencies.ayarlarProvider.load);
  }

  @override
  void dispose() {
    _dependencies.dispose();
    super.dispose();
  }

  ThemeMode _resolveThemeMode() {
    final pref = _dependencies.ayarlarProvider.state.data?.themePreference;
    switch (pref) {
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
        return ThemeMode.dark;
      case ThemePreference.system:
      case null:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _dependencies.ayarlarProvider,
      builder: (context, _) {
        return MaterialApp(
          title: 'Güvenli Şehrim',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _resolveThemeMode(),
          onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings, _dependencies),
          home: AppShell(dependencies: _dependencies),
        );
      },
    );
  }
}
