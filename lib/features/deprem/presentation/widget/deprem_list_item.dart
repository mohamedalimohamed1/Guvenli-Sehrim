import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class DepremListItem extends StatelessWidget {
  const DepremListItem({
    super.key,
    required this.title,
    required this.magnitude,
    required this.timeLabel,
    this.itemKey,
    this.onTap,
    this.isSelected = false,
  });

  final String title;
  final String magnitude;
  final String timeLabel;
  final Key? itemKey;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: itemKey,
      onTap: onTap,
      child: InfoCard(
        leadingAccentColor: isSelected ? AppColors.error : null,
        backgroundColor: isSelected
            ? AppColors.surfaceContainerHigh
            : AppColors.surfaceContainerLow,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 4),
                  Text(
                    timeLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              magnitude,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.error,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
