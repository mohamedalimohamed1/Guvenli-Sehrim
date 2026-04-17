import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';

class HavaSearchBar extends StatelessWidget {
  const HavaSearchBar({
    super.key,
    required this.placeholder,
    required this.suggestionCount,
    required this.onSearchTap,
    required this.onGpsTap,
  });

  final String placeholder;
  final int suggestionCount;
  final VoidCallback onSearchTap;
  final VoidCallback onGpsTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onSearchTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, size: 18, color: AppColors.outline),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      placeholder,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.outline,
                      ),
                    ),
                  ),
                  Text(
                    '$suggestionCount öneri',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onGpsTap,
          child: Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.my_location, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
