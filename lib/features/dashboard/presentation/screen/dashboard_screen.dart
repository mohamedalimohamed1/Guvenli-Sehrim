import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/constants/widget_keys.dart';
import 'package:guvenli_sehrim/core/theme/app_colors.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/dashboard/domain/model/dashboard_models.dart';
import 'package:guvenli_sehrim/features/dashboard/presentation/provider/dashboard_provider.dart';
import 'package:guvenli_sehrim/features/dashboard/presentation/widget/dashboard_summary_card.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/info_card.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';
import 'package:guvenli_sehrim/shared/widgets/top_location_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({
    required this.provider,
    super.key,
  });

  final DashboardProvider provider;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
        final state = widget.provider.state;
        return BaseScaffold(
          title: 'Dashboard',
          trailing: IconButton(
            key: WidgetKeys.dashboardRefresh,
            onPressed: widget.provider.refresh,
            icon: const Icon(Icons.refresh_rounded, color: AppColors.primary),
          ),
          child: _buildState(context, state),
        );
      },
    );
  }

  Widget _buildState(BuildContext context, ViewState<DashboardSnapshot> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(context, state.data!, showRefreshing: true);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'Dashboard yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return Column(
          children: [
            if (state.isOffline)
              const OfflineBanner(
                bannerKey: WidgetKeys.dashboardOfflineBanner,
              ),
            const Expanded(
              child: EmptyView(message: 'Dashboard için gösterilecek veri yok.'),
            ),
          ],
        );
      case ViewStatus.success:
        return _buildSuccess(context, state.data!);
    }
  }

  Widget _buildSuccess(
    BuildContext context,
    DashboardSnapshot snapshot, {
    bool showRefreshing = false,
  }) {
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          TopLocationBar(
            location: '${snapshot.district}, ${snapshot.city}',
            textKey: WidgetKeys.dashboardKonumText,
            trailing: showRefreshing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 6),
          Text(
            'Son güncelleme ${_timeLabel(snapshot.lastUpdated)}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          if (snapshot.isOffline)
            const OfflineBanner(
              bannerKey: WidgetKeys.dashboardOfflineBanner,
            ),
          if (snapshot.isOffline) const SizedBox(height: 16),
          const SectionHeader(
            eyebrow: 'Şehir Durumu',
            title: 'Özet Modüller',
            subtitle: 'Mock repository üzerinden beslenen canlı özet kartları',
          ),
          const SizedBox(height: 16),
          ..._buildSummaryCards(snapshot.cards),
          const SizedBox(height: 24),
          const SectionHeader(
            eyebrow: 'Öne Çıkanlar',
            title: 'Güvenlik Duyuruları',
          ),
          const SizedBox(height: 12),
          ...snapshot.alerts.map(
            (alert) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: InfoCard(
                leadingAccentColor: _severityColor(alert.severity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(alert.title, style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(height: 6),
                    Text(alert.message),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSummaryCards(List<DashboardCardSummary> cards) {
    return cards
        .map(
          (card) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: DashboardSummaryCard(
              cardKey: _cardKey(card.featureKey),
              title: card.title,
              value: card.primaryValue,
              subtitle: '${card.secondaryValue} · ${card.statusLabel}',
              leadingAccentColor: _cardAccent(card.featureKey),
            ),
          ),
        )
        .toList(growable: false);
  }

  Key? _cardKey(String featureKey) {
    switch (featureKey) {
      case 'deprem':
        return WidgetKeys.dashboardDepremCard;
      case 'hava':
        return WidgetKeys.dashboardHavaCard;
      case 'aqi':
        return WidgetKeys.dashboardAqiCard;
      case 'namaz':
        return WidgetKeys.dashboardNamazCard;
      case 'doviz':
        return WidgetKeys.dashboardDovizCard;
      default:
        return null;
    }
  }

  Color _cardAccent(String featureKey) {
    switch (featureKey) {
      case 'deprem':
        return AppColors.error;
      case 'aqi':
        return AppColors.tertiary;
      case 'doviz':
        return AppColors.secondary;
      case 'namaz':
        return AppColors.primaryContainer;
      case 'hava':
      default:
        return AppColors.primary;
    }
  }

  Color _severityColor(String severity) {
    switch (severity) {
      case 'warning':
        return AppColors.tertiary;
      case 'error':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }

  String _timeLabel(DateTime value) {
    return '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
}
