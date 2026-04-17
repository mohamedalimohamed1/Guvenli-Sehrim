class AirQualitySnapshot {
  const AirQualitySnapshot({
    required this.city,
    required this.mainStation,
    required this.aqiValue,
    required this.category,
    required this.colorHex,
    required this.healthRecommendation,
    required this.trend,
    required this.stations,
  });

  final String city;
  final String mainStation;
  final int aqiValue;
  final String category;
  final String colorHex;
  final String healthRecommendation;
  final List<AqiTrendPoint> trend;
  final List<AqiStation> stations;
}

class AqiTrendPoint {
  const AqiTrendPoint({
    required this.hourLabel,
    required this.value,
  });

  final String hourLabel;
  final int value;
}

class AqiStation {
  const AqiStation({
    required this.id,
    required this.name,
    required this.district,
    required this.aqiValue,
    required this.category,
    required this.latitude,
    required this.longitude,
  });

  final String id;
  final String name;
  final String district;
  final int aqiValue;
  final String category;
  final double latitude;
  final double longitude;
}
