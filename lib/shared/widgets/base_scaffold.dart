import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 64,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              color: AppColors.surfaceContainerLow,
              child: Row(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  trailing ?? const SizedBox.shrink(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: padding ?? const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
