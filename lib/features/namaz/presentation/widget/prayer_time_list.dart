import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/namaz/domain/model/prayer_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class PrayerTimeList extends StatelessWidget {
  const PrayerTimeList({
    super.key,
    required this.items,
  });

  final List<PrayerTime> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InfoCard(
                leadingAccentColor: item.isNext ? AppColors.primary : null,
                backgroundColor: item.isNext
                    ? AppColors.surfaceContainerHigh
                    : AppColors.surfaceContainerLow,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: item.isNext ? AppColors.primary : null,
                        ),
                      ),
                    ),
                    Text(
                      item.time,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: item.isNext ? AppColors.primary : null,
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
