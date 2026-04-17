import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';
import 'package:guvenli_sehrim/features/doviz/presentation/provider/doviz_provider.dart';
import 'package:guvenli_sehrim/features/doviz/presentation/widget/currency_highlight_card.dart';
import 'package:guvenli_sehrim/features/doviz/presentation/widget/currency_list.dart';
import 'package:guvenli_sehrim/features/doviz/presentation/widget/market_trend_section.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';

class DovizScreen extends StatefulWidget {
  const DovizScreen({
    required this.provider,
    super.key,
  });

  final DovizProvider provider;

  @override
  State<DovizScreen> createState() => _DovizScreenState();
}

class _DovizScreenState extends State<DovizScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.provider.state.status == ViewStatus.initial) {
      Future.microtask(widget.provider.load);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.provider,
      builder: (context, _) {
        return BaseScaffold(
          title: 'Döviz',
          child: _buildState(widget.provider.state),
        );
      },
    );
  }

  Widget _buildState(ViewState<MarketsSnapshot> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(state.data!, isOffline: state.isOffline);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'Piyasa verileri yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return const EmptyView(message: 'Piyasa verisi bulunamadı.');
      case ViewStatus.success:
        return _buildSuccess(state.data!, isOffline: state.isOffline);
    }
  }

  Widget _buildSuccess(MarketsSnapshot snapshot, {bool isOffline = false}) {
    final highlights = snapshot.highlights;
    final hero = highlights.isNotEmpty ? highlights.first : null;
    final sideHighlights = highlights.length > 1 ? highlights.skip(1).take(2).toList() : const <MarketQuote>[];
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          const SectionHeader(
            eyebrow: 'Canlı Piyasa',
            title: 'Döviz ve Altın',
            subtitle: 'Öne çıkan enstrümanlar, liste ve trend alanı mock repository ile bağlı',
          ),
          const SizedBox(height: 16),
          if (isOffline) const OfflineBanner(),
          if (isOffline) const SizedBox(height: 16),
          if (hero != null)
            CurrencyHighlightCard(
              title: hero.name,
              value: hero.sellPrice.toStringAsFixed(2),
              changeLabel: _changeLabel(hero.dailyChangePercent),
              leadingAccentColor: AppColors.tertiary,
            ),
          if (hero != null) const SizedBox(height: 16),
          if (sideHighlights.isNotEmpty)
            Row(
              children: sideHighlights
                  .map(
                    (item) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: item == sideHighlights.first ? 12 : 0,
                        ),
                        child: CurrencyHighlightCard(
                          title: item.code,
                          value: item.sellPrice.toStringAsFixed(2),
                          changeLabel: _changeLabel(item.dailyChangePercent),
                          leadingAccentColor: AppColors.primary,
                        ),
                      ),
                    ),
                  )
                  .toList(growable: false),
            ),
          const SizedBox(height: 24),
          MarketTrendSection(items: snapshot.trend),
          const SizedBox(height: 24),
          const SectionHeader(
            eyebrow: 'Diğer Varlıklar',
            title: 'Takip Listesi',
          ),
          const SizedBox(height: 12),
          CurrencyList(
            items: snapshot.allQuotes,
            onFavoriteToggle: widget.provider.toggleFavorite,
          ),
        ],
      ),
    );
  }

  String _changeLabel(double value) {
    final prefix = value >= 0 ? '+' : '';
    return '$prefix${value.toStringAsFixed(2)}%';
  }
}

