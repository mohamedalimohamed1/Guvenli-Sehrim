import 'package:guvenli_sehrim/features/namaz/domain/model/prayer_models.dart';

class PrayerTimesSnapshotDto {
  const PrayerTimesSnapshotDto({
    required this.city,
    required this.nextPrayerName,
    required this.nextPrayerTime,
    required this.countdownLabel,
    required this.todayTimes,
    required this.weeklySchedule,
  });

  final String city;
  final String nextPrayerName;
  final String nextPrayerTime;
  final String countdownLabel;
  final List<PrayerTimeDto> todayTimes;
  final List<PrayerDayScheduleDto> weeklySchedule;

  factory PrayerTimesSnapshotDto.fromJson(Map<String, dynamic> json) {
    final nextPrayer = json['siradakiVakit'] as Map<String, dynamic>? ?? const {};
    return PrayerTimesSnapshotDto(
      city: json['sehir'] as String? ?? '',
      nextPrayerName: nextPrayer['ad'] as String? ?? '',
      nextPrayerTime: nextPrayer['saat'] as String? ?? '',
      countdownLabel: nextPrayer['geriSayim'] as String? ?? '',
      todayTimes: (json['bugun'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(PrayerTimeDto.fromJson)
          .toList(growable: false),
      weeklySchedule: (json['haftalik'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(PrayerDayScheduleDto.fromJson)
          .toList(growable: false),
    );
  }

  PrayerTimesSnapshot toDomain() {
    return PrayerTimesSnapshot(
      city: city,
      nextPrayerName: nextPrayerName,
      nextPrayerTime: nextPrayerTime,
      countdownLabel: countdownLabel,
      todayTimes:
          todayTimes.map((item) => item.toDomain()).toList(growable: false),
      weeklySchedule: weeklySchedule
          .map((item) => item.toDomain())
          .toList(growable: false),
    );
  }
}

class PrayerDayScheduleDto {
  const PrayerDayScheduleDto({
    required this.dayLabel,
    required this.times,
  });

  final String dayLabel;
  final List<PrayerTimeDto> times;

  factory PrayerDayScheduleDto.fromJson(Map<String, dynamic> json) {
    return PrayerDayScheduleDto(
      dayLabel: json['gun'] as String? ?? '',
      times: (json['vakitler'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(PrayerTimeDto.fromJson)
          .toList(growable: false),
    );
  }

  PrayerDaySchedule toDomain() {
    return PrayerDaySchedule(
      dayLabel: dayLabel,
      times: times.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}

class PrayerTimeDto {
  const PrayerTimeDto({
    required this.name,
    required this.time,
    required this.isNext,
  });

  final String name;
  final String time;
  final bool isNext;

  factory PrayerTimeDto.fromJson(Map<String, dynamic> json) {
    return PrayerTimeDto(
      name: json['ad'] as String? ?? '',
      time: json['saat'] as String? ?? '',
      isNext: json['siradaki'] as bool? ?? false,
    );
  }

  PrayerTime toDomain() {
    return PrayerTime(name: name, time: time, isNext: isNext);
  }
}
