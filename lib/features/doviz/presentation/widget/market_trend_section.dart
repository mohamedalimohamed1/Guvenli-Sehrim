import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';
import 'package:guvenli_sehrim/shared/widgets/chart_section_container.dart';

class MarketTrendSection extends StatelessWidget {
  const MarketTrendSection({
    super.key,
    required this.items,
  });

  final List<MarketTrendPoint> items;

  @override
  Widget build(BuildContext context) {
    final maxValue =
        items.fold<double>(0, (max, item) => item.value > max ? item.value : max);
    return ChartSectionContainer(
      title: 'Trend Görünümü',
      subtitle: 'Sparkline ve çoklu enstrüman alanı',
      child: SizedBox(
        height: 110,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: items
              .map(
                (item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: maxValue == 0 ? 0 : (item.value / maxValue) * 80,
                          decoration: BoxDecoration(
                            color: item.value == maxValue
                                ? AppColors.tertiary
                                : AppColors.surfaceContainerLow,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item.label, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
      ),
    );
  }
}
