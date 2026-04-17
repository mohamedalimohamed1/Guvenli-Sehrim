import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({
    super.key,
    required this.selectedTheme,
    required this.onThemeSelected,
  });

  final ThemePreference selectedTheme;
  final ValueChanged<ThemePreference> onThemeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ThemeOption(
            label: 'Aydınlık',
            icon: Icons.light_mode_outlined,
            isActive: selectedTheme == ThemePreference.light,
            onTap: () => onThemeSelected(ThemePreference.light),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ThemeOption(
            label: 'Karanlık',
            icon: Icons.dark_mode_outlined,
            isActive: selectedTheme == ThemePreference.dark,
            onTap: () => onThemeSelected(ThemePreference.dark),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ThemeOption(
            label: 'Sistem',
            icon: Icons.brightness_auto_outlined,
            isActive: selectedTheme == ThemePreference.system,
            onTap: () => onThemeSelected(ThemePreference.system),
          ),
        ),
      ],
    );
  }
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: InfoCard(
        backgroundColor: isActive ? AppColors.primaryContainer : AppColors.surfaceContainerHigh,
        child: Column(
          children: [
            Icon(icon, color: isActive ? AppColors.primary : AppColors.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isActive ? AppColors.primary : null,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
