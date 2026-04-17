import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/provider/deprem_provider.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/widget/deprem_detail_panel.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/widget/deprem_filter_bar.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/widget/deprem_list_item.dart';
import 'package:guvenli_sehrim/features/deprem/presentation/widget/deprem_map_section.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';

class DepremScreen extends StatefulWidget {
  const DepremScreen({
    required this.provider,
    super.key,
  });

  final DepremProvider provider;

  @override
  State<DepremScreen> createState() => _DepremScreenState();
}

class _DepremScreenState extends State<DepremScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.provider.feedState.status == ViewStatus.initial) {
      Future.microtask(widget.provider.load);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.provider,
      builder: (context, _) {
        return BaseScaffold(
          title: 'Deprem',
          child: _buildState(widget.provider.feedState),
        );
      },
    );
  }

  Widget _buildState(ViewState<EarthquakeFeed> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(state.data!);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'Deprem verileri yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return const EmptyView(message: 'Deprem kaydı bulunamadı.');
      case ViewStatus.success:
        return _buildSuccess(state.data!, isOffline: state.isOffline);
    }
  }

  Widget _buildSuccess(EarthquakeFeed feed, {bool isOffline = false}) {
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          const SectionHeader(
            eyebrow: 'Taktik İzleme',
            title: 'Deprem Akışı',
            subtitle: 'Filtre, harita, liste ve detay aynı state üzerinden besleniyor',
          ),
          const SizedBox(height: 16),
          if (isOffline) const OfflineBanner(),
          if (isOffline) const SizedBox(height: 16),
          DepremFilterBar(
            options: feed.filterOptions,
            selectedCode: widget.provider.selectedFilterCode,
            onSelected: widget.provider.selectFilter,
          ),
          const SizedBox(height: 16),
          DepremMapSection(activePointCount: feed.mapPoints.length),
          const SizedBox(height: 16),
          DepremDetailPanel(
            detail: widget.provider.selectedDetail,
            errorMessage: widget.provider.detailErrorMessage,
          ),
          const SizedBox(height: 16),
          const SectionHeader(
            eyebrow: 'Kayıtlar',
            title: 'Son Olaylar',
          ),
          const SizedBox(height: 12),
          ...feed.events.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DepremListItem(
                itemKey: Key('deprem_item_${item.id}'),
                title: item.locationName,
                magnitude: item.magnitude.toStringAsFixed(1),
                timeLabel: _timeLabel(item.occurredAt),
                isSelected: widget.provider.selectedEventId == item.id,
                onTap: () => widget.provider.selectEvent(item.id),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _timeLabel(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}.${value.month.toString().padLeft(2, '0')} ${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }
}
