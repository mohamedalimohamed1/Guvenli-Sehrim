import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.child,
    this.padding,
    this.leadingAccentColor,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? leadingAccentColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          if (leadingAccentColor != null)
            Container(
              width: 4,
              height: 56,
              margin: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                color: leadingAccentColor,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          Expanded(
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
