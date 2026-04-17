import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class CurrencyHighlightCard extends StatelessWidget {
  const CurrencyHighlightCard({
    super.key,
    required this.title,
    required this.value,
    required this.changeLabel,
    this.leadingAccentColor,
  });

  final String title;
  final String value;
  final String changeLabel;
  final Color? leadingAccentColor;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      leadingAccentColor: leadingAccentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 10),
          Text(value, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            changeLabel,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.secondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
