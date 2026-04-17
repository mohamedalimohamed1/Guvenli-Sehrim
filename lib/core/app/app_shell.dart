import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/app/app_dependencies.dart';
import 'package:guvenli_sehrim/core/constants/widget_keys.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/aqi/presentation/screen/aqi_screen.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/screen/ayarlar_screen.dart';
import 'package:guvenli_sehrim/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/screen/deprem_screen.dart';
import 'package:guvenli_sehrim/features/doviz/presentation/screen/doviz_screen.dart';
import 'package:guvenli_sehrim/features/hava/presentation/screen/hava_screen.dart';
import 'package:guvenli_sehrim/features/namaz/presentation/screen/namaz_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  late final List<Widget> _screens;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    final d = widget.dependencies;
    _screens = [
      DashboardScreen(provider: d.dashboardProvider),
      DepremScreen(provider: d.depremProvider),
      HavaScreen(provider: d.havaProvider),
      AqiScreen(provider: d.aqiProvider),
      NamazScreen(provider: d.namazProvider),
      DovizScreen(provider: d.dovizProvider),
      AyarlarScreen(provider: d.ayarlarProvider),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              itemKey: WidgetKeys.navDashboard,
              icon: Icons.dashboard_outlined,
              activeIcon: Icons.dashboard_rounded,
              isSelected: _currentIndex == 0,
              onTap: () => _select(0),
            ),
            _NavItem(
              itemKey: WidgetKeys.navDeprem,
              icon: Icons.crisis_alert_outlined,
              activeIcon: Icons.crisis_alert,
              isSelected: _currentIndex == 1,
              onTap: () => _select(1),
            ),
            _NavItem(
              itemKey: WidgetKeys.navHava,
              icon: Icons.cloud_outlined,
              activeIcon: Icons.cloud,
              isSelected: _currentIndex == 2,
              onTap: () => _select(2),
            ),
            _NavItem(
              itemKey: WidgetKeys.navAqi,
              icon: Icons.air_outlined,
              activeIcon: Icons.air,
              isSelected: _currentIndex == 3,
              onTap: () => _select(3),
            ),
            _NavItem(
              itemKey: WidgetKeys.navNamaz,
              icon: Icons.schedule_outlined,
              activeIcon: Icons.schedule,
              isSelected: _currentIndex == 4,
              onTap: () => _select(4),
            ),
            _NavItem(
              itemKey: WidgetKeys.navDoviz,
              icon: Icons.currency_exchange_outlined,
              activeIcon: Icons.currency_exchange,
              isSelected: _currentIndex == 5,
              onTap: () => _select(5),
            ),
            _NavItem(
              itemKey: WidgetKeys.navAyarlar,
              icon: Icons.settings_outlined,
              activeIcon: Icons.settings,
              isSelected: _currentIndex == 6,
              onTap: () => _select(6),
            ),
          ],
        ),
      ),
    );
  }

  void _select(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.itemKey,
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.onTap,
  });

  final Key itemKey;
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: itemKey,
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryContainer],
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
          size: 22,
        ),
      ),
    );
  }
}
