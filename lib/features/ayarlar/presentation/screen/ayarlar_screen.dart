import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/provider/ayarlar_provider.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/widget/action_section.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/widget/refresh_frequency_selector.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/widget/theme_selector.dart';
import 'package:guvenli_sehrim/features/ayarlar/presentation/widget/threshold_slider.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';

class AyarlarScreen extends StatefulWidget {
  const AyarlarScreen({
    required this.provider,
    super.key,
  });

  final AyarlarProvider provider;

  @override
  State<AyarlarScreen> createState() => _AyarlarScreenState();
}

class _AyarlarScreenState extends State<AyarlarScreen> {
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
          title: 'Ayarlar',
          child: _buildState(widget.provider.state),
        );
      },
    );
  }

  Widget _buildState(ViewState<SettingsSnapshot> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(state.data!, isOffline: state.isOffline);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'Ayarlar yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return const EmptyView(message: 'Kayıtlı ayar verisi bulunamadı.');
      case ViewStatus.success:
        return _buildSuccess(state.data!, isOffline: state.isOffline);
    }
  }

  Widget _buildSuccess(SettingsSnapshot snapshot, {bool isOffline = false}) {
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          const SectionHeader(
            eyebrow: 'Yönetim Paneli',
            title: 'Uygulama Ayarları',
            subtitle: 'Tema, eşik, yenileme ve aksiyon alanları repository state üzerinden okunuyor',
          ),
          const SizedBox(height: 16),
          if (isOffline) const OfflineBanner(),
          if (isOffline) const SizedBox(height: 16),
          const SectionHeader(title: 'Tema'),
          const SizedBox(height: 12),
          ThemeSelector(
            selectedTheme: snapshot.themePreference,
            onThemeSelected: widget.provider.updateThemePreference,
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Eşikler'),
          const SizedBox(height: 12),
          ThresholdSlider(
            title: 'Deprem Uyarıları',
            subtitle: '${snapshot.earthquakeThreshold.toStringAsFixed(1)} ve üzeri olaylarda bildirim',
            valueLabel: '${snapshot.earthquakeThreshold.toStringAsFixed(1)}+',
            value: snapshot.earthquakeThreshold,
            min: 1.0,
            max: 10.0,
            onChanged: widget.provider.updateEarthquakeThreshold,
          ),
          const SizedBox(height: 12),
          ThresholdSlider(
            title: 'AQI Uyarıları',
            subtitle: 'AQI seviyesi ${snapshot.aqiThreshold} üstünde uyar',
            valueLabel: '${snapshot.aqiThreshold}',
            value: snapshot.aqiThreshold.toDouble(),
            min: 0.0,
            max: 300.0,
            onChanged: (val) => widget.provider.updateAqiThreshold(val.toInt()),
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Yenileme'),
          const SizedBox(height: 12),
          RefreshFrequencySelector(
            currentMinutes: snapshot.refreshIntervalMinutes,
            availableIntervals: snapshot.availableIntervals,
            onIntervalSelected: widget.provider.updateRefreshInterval,
          ),
          const SizedBox(height: 24),
          const SectionHeader(title: 'Önbellek ve Aksiyonlar'),
          const SizedBox(height: 12),
          ActionSection(
            cacheSizeMb: snapshot.cacheSizeMb,
            onClearCache: widget.provider.clearCache,
            onSignOut: () {
              debugPrint('Oturumu Kapat clicked');
            },
          ),
        ],
      ),
    );
  }
}

