import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';
import 'package:guvenli_sehrim/shared/widgets/chart_section_container.dart';

class AqiChart extends StatelessWidget {
  const AqiChart({
    super.key,
    required this.items,
  });

  final List<AqiTrendPoint> items;

  @override
  Widget build(BuildContext context) {
    final maxValue = items.fold<int>(0, (max, item) => item.value > max ? item.value : max);
    return ChartSectionContainer(
      title: 'Hava Kalitesi Trendi',
      subtitle: 'Gün içi değişim görünümü',
      child: SizedBox(
        height: 160,
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
                          height: maxValue == 0 ? 0 : (item.value / maxValue) * 108,
                          decoration: BoxDecoration(
                            color: item.value >= 80
                                ? AppColors.tertiary
                                : AppColors.surfaceContainerLow,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(item.hourLabel, style: Theme.of(context).textTheme.bodySmall),
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
