import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class AqiIndicator extends StatelessWidget {
  const AqiIndicator({
    super.key,
    required this.value,
    required this.category,
    required this.recommendation,
  });

  final int value;
  final String category;
  final String recommendation;

  Color get _accentColor {
    if (value >= 150) {
      return AppColors.error;
    }
    if (value >= 100) {
      return AppColors.tertiary;
    }
    return AppColors.secondary;
  }

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      leadingAccentColor: _accentColor,
      child: Column(
        children: [
          Container(
            width: 190,
            height: 190,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: _accentColor, width: 12),
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$value', style: Theme.of(context).textTheme.displayLarge),
                  Text(
                    category,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: _accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            recommendation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
