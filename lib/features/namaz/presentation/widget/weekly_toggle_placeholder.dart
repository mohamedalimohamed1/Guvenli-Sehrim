import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';

class WeeklyTogglePlaceholder extends StatelessWidget {
  const WeeklyTogglePlaceholder({
    super.key,
    required this.dayCount,
  });

  final int dayCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Haftalık Görünüm',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '$dayCount gün',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
