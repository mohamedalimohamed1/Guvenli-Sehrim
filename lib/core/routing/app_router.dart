import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/app/app_dependencies.dart';
import 'package:guvenli_sehrim/core/app/app_shell.dart';
import 'package:guvenli_sehrim/core/routing/app_routes.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings, AppDependencies dependencies) {
    switch (settings.name) {
      case AppRoutes.dashboard:
      case AppRoutes.deprem:
      case AppRoutes.hava:
      case AppRoutes.aqi:
      case AppRoutes.namaz:
      case AppRoutes.doviz:
      case AppRoutes.ayarlar:
      default:
        return MaterialPageRoute(builder: (_) => AppShell(dependencies: dependencies));
    }
  }
}
