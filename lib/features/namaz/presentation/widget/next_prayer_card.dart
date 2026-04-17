import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class NextPrayerCard extends StatelessWidget {
  const NextPrayerCard({
    super.key,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.countdownLabel,
  });

  final String nextPrayerName;
  final String nextPrayerTime;
  final String countdownLabel;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      leadingAccentColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sıradaki Vakit',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 12),
          Text(nextPrayerName, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(nextPrayerTime, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 12),
          Text(
            countdownLabel,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'kaldı',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
