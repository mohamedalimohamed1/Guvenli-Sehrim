import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class DepremDetailPanel extends StatelessWidget {
  const DepremDetailPanel({
    super.key,
    this.detail,
    this.errorMessage,
  });

  final EarthquakeDetail? detail;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    if (detail == null) {
      return InfoCard(
        leadingAccentColor: AppColors.error,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Detay Alanı', style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'Seçili deprem için detay bilgisi burada gösterilecek.',
            ),
          ],
        ),
      );
    }

    final item = detail!;
    return InfoCard(
      leadingAccentColor: AppColors.error,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.event.locationName, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          Text(
            'M ${item.event.magnitude.toStringAsFixed(1)} · ${item.event.depthKm.toStringAsFixed(1)} km',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'En yakın ilçe: ${item.closestDistrict} · ${item.distanceToDistrictKm.toStringAsFixed(1)} km',
          ),
          const SizedBox(height: 8),
          Text(item.riskNote),
        ],
      ),
    );
  }
}
