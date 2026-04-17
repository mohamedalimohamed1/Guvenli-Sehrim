import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';
import 'package:guvenli_sehrim/shared/widgets/metric_tile.dart';

class CurrentWeatherCard extends StatelessWidget {
  const CurrentWeatherCard({
    super.key,
    required this.locationLabel,
    required this.temperatureLabel,
    required this.description,
    required this.humidityLabel,
    required this.windLabel,
    required this.pressureLabel,
    required this.feelsLikeLabel,
  });

  final String locationLabel;
  final String temperatureLabel;
  final String description;
  final String humidityLabel;
  final String windLabel;
  final String pressureLabel;
  final String feelsLikeLabel;

  @override
  Widget build(BuildContext context) {
    return InfoCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            locationLabel,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(temperatureLabel, style: Theme.of(context).textTheme.displayLarge),
          const SizedBox(height: 6),
          Text(description, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 150,
                child: MetricTile(label: 'Nem', value: humidityLabel, unit: '%'),
              ),
              SizedBox(
                width: 150,
                child: MetricTile(label: 'Rüzgar', value: windLabel, unit: 'm/sn'),
              ),
              SizedBox(
                width: 150,
                child: MetricTile(label: 'Basınç', value: pressureLabel, unit: 'hPa'),
              ),
              SizedBox(
                width: 150,
                child: MetricTile(label: 'Hissedilen', value: feelsLikeLabel, unit: '°C'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
