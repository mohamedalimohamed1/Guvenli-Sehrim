import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class HourlyForecastList extends StatelessWidget {
  const HourlyForecastList({
    super.key,
    required this.items,
  });

  final List<HourlyForecast> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 132,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          final isActive = index == 0;
          return SizedBox(
            width: 92,
            child: InfoCard(
              backgroundColor: isActive
                  ? AppColors.primaryContainer
                  : AppColors.surfaceContainerHigh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.hourLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isActive
                          ? AppColors.onPrimary
                          : AppColors.onSurfaceVariant,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Icon(
                    item.iconCode.contains('rain')
                        ? Icons.water_drop_outlined
                        : item.iconCode.contains('cloud')
                            ? Icons.cloud_outlined
                            : Icons.wb_sunny_outlined,
                    color: isActive ? AppColors.onPrimary : AppColors.primary,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${item.temperature}°',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: isActive ? AppColors.onPrimary : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
