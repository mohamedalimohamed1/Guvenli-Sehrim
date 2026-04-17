import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class AqiStationList extends StatelessWidget {
  const AqiStationList({
    super.key,
    required this.stations,
  });

  final List<AqiStation> stations;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: stations
          .map(
            (station) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InfoCard(
                backgroundColor: AppColors.surfaceContainerLow,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            station.name,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            station.district,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${station.aqiValue}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.tertiary,
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
