import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class DailyForecastList extends StatelessWidget {
  const DailyForecastList({
    super.key,
    required this.items,
  });

  final List<DailyForecast> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (day) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InfoCard(
                backgroundColor: AppColors.surfaceContainerLow,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        day.dayLabel,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Icon(
                      day.iconCode.contains('rain')
                          ? Icons.water_drop_outlined
                          : day.iconCode.contains('cloud')
                              ? Icons.cloud_outlined
                              : Icons.wb_sunny_outlined,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '${day.maxTemperature}°',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${day.minTemperature}°',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}
