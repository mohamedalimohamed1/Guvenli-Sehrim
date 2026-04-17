import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';

class AirQualitySnapshotDto {
  const AirQualitySnapshotDto({
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
  final List<AqiTrendPointDto> trend;
  final List<AqiStationDto> stations;

  factory AirQualitySnapshotDto.fromJson(Map<String, dynamic> json) {
    return AirQualitySnapshotDto(
      city: json['sehir'] as String? ?? '',
      mainStation: json['anaIstasyon'] as String? ?? '',
      aqiValue: json['aqi'] as int? ?? 0,
      category: json['kategori'] as String? ?? '',
      colorHex: json['renk'] as String? ?? '#BDBDBD',
      healthRecommendation: json['oneri'] as String? ?? '',
      trend: (json['trend'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(AqiTrendPointDto.fromJson)
          .toList(growable: false),
      stations: (json['istasyonlar'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(AqiStationDto.fromJson)
          .toList(growable: false),
    );
  }

  AirQualitySnapshot toDomain() {
    return AirQualitySnapshot(
      city: city,
      mainStation: mainStation,
      aqiValue: aqiValue,
      category: category,
      colorHex: colorHex,
      healthRecommendation: healthRecommendation,
      trend: trend.map((item) => item.toDomain()).toList(growable: false),
      stations: stations.map((item) => item.toDomain()).toList(growable: false),
    );
  }
}

class AqiTrendPointDto {
  const AqiTrendPointDto({
    required this.hourLabel,
    required this.value,
  });

  final String hourLabel;
  final int value;

  factory AqiTrendPointDto.fromJson(Map<String, dynamic> json) {
    return AqiTrendPointDto(
      hourLabel: json['saat'] as String? ?? '',
      value: json['deger'] as int? ?? 0,
    );
  }

  AqiTrendPoint toDomain() {
    return AqiTrendPoint(hourLabel: hourLabel, value: value);
  }
}

class AqiStationDto {
  const AqiStationDto({
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

  factory AqiStationDto.fromJson(Map<String, dynamic> json) {
    return AqiStationDto(
      id: json['id'] as String? ?? '',
      name: json['ad'] as String? ?? '',
      district: json['ilce'] as String? ?? '',
      aqiValue: json['aqi'] as int? ?? 0,
      category: json['kategori'] as String? ?? '',
      latitude: (json['enlem'] as num? ?? 0).toDouble(),
      longitude: (json['boylam'] as num? ?? 0).toDouble(),
    );
  }

  AqiStation toDomain() {
    return AqiStation(
      id: id,
      name: name,
      district: district,
      aqiValue: aqiValue,
      category: category,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
