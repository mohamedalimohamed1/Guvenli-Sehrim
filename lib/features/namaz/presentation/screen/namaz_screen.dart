import 'package:flutter/material.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/namaz/domain/model/prayer_models.dart';
import 'package:guvenli_sehrim/features/namaz/presentation/provider/namaz_provider.dart';
import 'package:guvenli_sehrim/features/namaz/presentation/widget/next_prayer_card.dart';
import 'package:guvenli_sehrim/features/namaz/presentation/widget/prayer_time_list.dart';
import 'package:guvenli_sehrim/features/namaz/presentation/widget/weekly_toggle_placeholder.dart';
import 'package:guvenli_sehrim/shared/widgets/base_scaffold.dart';
import 'package:guvenli_sehrim/shared/widgets/empty_view.dart';
import 'package:guvenli_sehrim/shared/widgets/error_view.dart';
import 'package:guvenli_sehrim/shared/widgets/loading_view.dart';
import 'package:guvenli_sehrim/shared/widgets/offline_banner.dart';
import 'package:guvenli_sehrim/shared/widgets/section_header.dart';

class NamazScreen extends StatefulWidget {
  const NamazScreen({
    required this.provider,
    super.key,
  });

  final NamazProvider provider;

  @override
  State<NamazScreen> createState() => _NamazScreenState();
}

class _NamazScreenState extends State<NamazScreen> {
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
          title: 'Namaz',
          child: _buildState(widget.provider.state),
        );
      },
    );
  }

  Widget _buildState(ViewState<PrayerTimesSnapshot> state) {
    switch (state.status) {
      case ViewStatus.initial:
      case ViewStatus.loading:
        if (state.hasData) {
          return _buildSuccess(state.data!, isOffline: state.isOffline);
        }
        return const LoadingView();
      case ViewStatus.error:
        return ErrorView(
          message: state.failure?.message ?? 'Namaz vakitleri yüklenemedi.',
          onRetry: widget.provider.refresh,
        );
      case ViewStatus.empty:
        return const EmptyView(message: 'Namaz vakti verisi bulunamadı.');
      case ViewStatus.success:
        return _buildSuccess(state.data!, isOffline: state.isOffline);
    }
  }

  Widget _buildSuccess(PrayerTimesSnapshot snapshot, {bool isOffline = false}) {
    return RefreshIndicator(
      onRefresh: widget.provider.refresh,
      child: ListView(
        children: [
          SectionHeader(
            eyebrow: 'Bugün',
            title: snapshot.city,
            subtitle: 'Günlük vakit planı',
            action: WeeklyTogglePlaceholder(dayCount: snapshot.weeklySchedule.length),
          ),
          const SizedBox(height: 16),
          if (isOffline) const OfflineBanner(),
          if (isOffline) const SizedBox(height: 16),
          NextPrayerCard(
            nextPrayerName: snapshot.nextPrayerName,
            nextPrayerTime: snapshot.nextPrayerTime,
            countdownLabel: snapshot.countdownLabel,
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            eyebrow: 'Günlük Liste',
            title: 'Vakit Çizelgesi',
          ),
          const SizedBox(height: 12),
          PrayerTimeList(items: snapshot.todayTimes),
        ],
      ),
    );
  }
}
