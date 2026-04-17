class PrayerTimesSnapshot {
  const PrayerTimesSnapshot({
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
  final List<PrayerTime> todayTimes;
  final List<PrayerDaySchedule> weeklySchedule;
}

class PrayerTime {
  const PrayerTime({
    required this.name,
    required this.time,
    required this.isNext,
  });

  final String name;
  final String time;
  final bool isNext;
}

class PrayerDaySchedule {
  const PrayerDaySchedule({
    required this.dayLabel,
    required this.times,
  });

  final String dayLabel;
  final List<PrayerTime> times;
}
