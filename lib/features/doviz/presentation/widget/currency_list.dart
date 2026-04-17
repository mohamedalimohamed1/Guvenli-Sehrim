import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';

class CurrencyList extends StatelessWidget {
  const CurrencyList({
    super.key,
    required this.items,
    required this.onFavoriteToggle,
  });

  final List<MarketQuote> items;
  final ValueChanged<String> onFavoriteToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (item) => Padding(
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
                            '${item.code} / TRY',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.name,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(item.sellPrice.toStringAsFixed(2)),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: () => onFavoriteToggle(item.code),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          item.isFavorite ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: item.isFavorite ? AppColors.primary : AppColors.outline,
                        ),
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
