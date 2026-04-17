import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';
import 'package:guvenli_sehrim/features/hava/presentation/provider/hava_provider.dart';
import 'package:guvenli_sehrim/features/hava/presentation/widget/current_weather_card.dart';
import 'package:guvenli_sehrim/features/hava/presentation/widget/daily_forecast_list.dart';
import 'package:guvenli_sehrim/features/hava/presentation/widget/hava_search_bar.dart';
import 'package:guvenli_sehrim/features/hava/presentation/widget/hourly_forecast_list.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';

class HavaScreen extends StatefulWidget {
  const HavaScreen({
    required this.provider,
    super.key,
  });

  final HavaProvider provider;

  @override
  State<HavaScreen> createState() => _HavaScreenState();
}

class _HavaScreenState extends State<HavaScreen> {
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
          title: 'Hava',
          child: _buildState(widget.provider.state),
        );
      },
    );
  }

  Widget _buildState(ViewState<WeatherSnapshot> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(state.data!, isOffline: state.isOffline);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'Hava durumu yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return const EmptyView(message: 'Hava durumu verisi bulunamadı.');
      case ViewStatus.success:
        return _buildSuccess(state.data!, isOffline: state.isOffline);
    }
  }

  Widget _buildSuccess(WeatherSnapshot snapshot, {bool isOffline = false}) {
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          HavaSearchBar(
            placeholder: '${snapshot.city} / ${snapshot.district}',
            suggestionCount: snapshot.searchSuggestions.length,
            onSearchTap: () {
              debugPrint('Hava search tapped');
            },
            onGpsTap: () {
              debugPrint('GPS location tapped');
            },
          ),
          const SizedBox(height: 16),
          if (isOffline) const OfflineBanner(),
          if (isOffline) const SizedBox(height: 16),
          CurrentWeatherCard(
            locationLabel: '${snapshot.city}, ${snapshot.district}',
            temperatureLabel: '${snapshot.current.temperature}°',
            description: snapshot.current.description,
            humidityLabel: '${snapshot.current.humidity}',
            windLabel: snapshot.current.windSpeed.toStringAsFixed(1),
            pressureLabel: '${snapshot.current.pressure}',
            feelsLikeLabel: '${snapshot.current.feelsLike}',
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            eyebrow: 'Saatlik Tahmin',
            title: 'Gün İçi Akış',
          ),
          const SizedBox(height: 12),
          HourlyForecastList(items: snapshot.hourly),
          const SizedBox(height: 24),
          const SectionHeader(
            eyebrow: '5 Günlük',
            title: 'İleri Görünüm',
          ),
          const SizedBox(height: 12),
          DailyForecastList(items: snapshot.daily),
        ],
      ),
    );
  }
}

