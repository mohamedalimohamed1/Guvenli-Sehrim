import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';
import 'package:guvenli_sehrim/features/aqi/presentation/provider/aqi_provider.dart';
import 'package:guvenli_sehrim/features/aqi/presentation/widget/aqi_chart.dart';
import 'package:guvenli_sehrim/features/aqi/presentation/widget/aqi_indicator.dart';
import 'package:guvenli_sehrim/features/aqi/presentation/widget/aqi_station_list.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/map_section_container.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';

class AqiScreen extends StatefulWidget {
  const AqiScreen({
    required this.provider,
    super.key,
  });

  final AqiProvider provider;

  @override
  State<AqiScreen> createState() => _AqiScreenState();
}

class _AqiScreenState extends State<AqiScreen> {
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
          title: 'AQI',
          child: _buildState(widget.provider.state),
        );
      },
    );
  }

  Widget _buildState(ViewState<AirQualitySnapshot> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(state.data!, isOffline: state.isOffline);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'AQI verileri yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return const EmptyView(message: 'AQI istasyon verisi bulunamadı.');
      case ViewStatus.success:
        return _buildSuccess(state.data!, isOffline: state.isOffline);
    }
  }

  Widget _buildSuccess(AirQualitySnapshot snapshot, {bool isOffline = false}) {
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          const SectionHeader(
            eyebrow: 'Şehir Durumu',
            title: 'Hava Kalitesi',
            subtitle: 'Gösterge, öneri, trend ve istasyon listesi mock state ile bağlı',
          ),
          const SizedBox(height: 16),
          if (isOffline) const OfflineBanner(),
          if (isOffline) const SizedBox(height: 16),
          AqiIndicator(
            value: snapshot.aqiValue,
            category: snapshot.category,
            recommendation: snapshot.healthRecommendation,
          ),
          const SizedBox(height: 16),
          MapSectionContainer(
            title: 'İstasyon Haritası',
            badge: '${snapshot.stations.length} aktif istasyon',
          ),
          const SizedBox(height: 16),
          AqiChart(items: snapshot.trend),
          const SizedBox(height: 16),
          const SectionHeader(
            eyebrow: 'İstasyonlar',
            title: 'Canlı Ölçümler',
          ),
          const SizedBox(height: 12),
          AqiStationList(stations: snapshot.stations),
        ],
      ),
    );
  }
}
