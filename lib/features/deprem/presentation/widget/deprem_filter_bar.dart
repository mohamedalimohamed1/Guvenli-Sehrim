import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';

class DepremFilterBar extends StatelessWidget {
  const DepremFilterBar({
    super.key,
    required this.options,
    required this.selectedCode,
    this.onSelected,
  });

  final List<EarthquakeFilterOption> options;
  final String? selectedCode;
  final ValueChanged<String>? onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options
          .map(
            (option) => _DepremFilterChip(
              label: option.label,
              isActive: option.code == selectedCode,
              onTap: onSelected == null ? null : () => onSelected!(option.code),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _DepremFilterChip extends StatelessWidget {
  const _DepremFilterChip({
    required this.label,
    this.isActive = false,
    this.onTap,
  });

  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          gradient: isActive
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryContainer],
                )
              : null,
          color: isActive ? null : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isActive ? AppColors.onPrimary : AppColors.onSurfaceVariant,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
