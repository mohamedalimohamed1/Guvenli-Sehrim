import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class RefreshFrequencySelector extends StatelessWidget {
  const RefreshFrequencySelector({
    super.key,
    required this.currentMinutes,
    required this.availableIntervals,
    required this.onIntervalSelected,
  });

  final int currentMinutes;
  final List<int> availableIntervals;
  final ValueChanged<int> onIntervalSelected;

  @override
  Widget build(BuildContext context) {
    final options = availableIntervals.isNotEmpty
        ? availableIntervals
        : const [5, 10, 15, 30, 60];
    return InfoCard(
      backgroundColor: AppColors.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yenileme Sıklığı',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            'Veri güncelleme aralığı',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: options.map((minutes) {
              final isSelected = minutes == currentMinutes;
              return GestureDetector(
                onTap: () => onIntervalSelected(minutes),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '$minutes dk',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              );
            }).toList(growable: false),
          ),
        ],
      ),
    );
  }
}
