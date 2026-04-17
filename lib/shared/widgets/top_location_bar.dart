import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';

class TopLocationBar extends StatelessWidget {
  const TopLocationBar({
    super.key,
    required this.location,
    this.textKey,
    this.trailing,
  });

  final String location;
  final Key? textKey;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.location_on_outlined, color: AppColors.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            location,
            key: textKey,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }
}

