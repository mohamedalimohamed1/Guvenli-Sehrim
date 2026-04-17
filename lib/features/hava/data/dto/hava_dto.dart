import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';

class WeatherSnapshotDto {
  const WeatherSnapshotDto({
    required this.city,
    required this.district,
    required this.backgroundKey,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.searchSuggestions,
  });

  final String city;
  final String district;
  final String backgroundKey;
  final CurrentWeatherDto current;
  final List<HourlyForecastDto> hourly;
  final List<DailyForecastDto> daily;
  final List<WeatherSearchSuggestionDto> searchSuggestions;

  factory WeatherSnapshotDto.fromJson(Map<String, dynamic> json) {
    return WeatherSnapshotDto(
      city: json['sehir'] as String? ?? '',
      district: json['ilce'] as String? ?? '',
      backgroundKey: json['arkaPlan'] as String? ?? 'neutral',
      current: CurrentWeatherDto.fromJson(
        json['anlik'] as Map<String, dynamic>? ?? const {},
      ),
      hourly: (json['saatlik'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(HourlyForecastDto.fromJson)
          .toList(growable: false),
      daily: (json['besGunluk'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(DailyForecastDto.fromJson)
          .toList(growable: false),
      searchSuggestions: (json['oneriler'] as List<dynamic>? ?? const [])
          .cast<Map<String, dynamic>>()
          .map(WeatherSearchSuggestionDto.fromJson)
          .toList(growable: false),
    );
  }

  WeatherSnapshot toDomain() {
    return WeatherSnapshot(
      city: city,
      district: district,
      current: current.toDomain(),
      hourly: hourly.map((item) => item.toDomain()).toList(growable: false),
      daily: daily.map((item) => item.toDomain()).toList(growable: false),
      searchSuggestions: searchSuggestions
          .map((item) => item.toDomain())
          .toList(growable: false),
      backgroundKey: backgroundKey,
    );
  }
}

class CurrentWeatherDto {
  const CurrentWeatherDto({
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.description,
    required this.iconCode,
  });

  final int temperature;
  final int feelsLike;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String description;
  final String iconCode;

  factory CurrentWeatherDto.fromJson(Map<String, dynamic> json) {
    return CurrentWeatherDto(
      temperature: json['sicaklik'] as int? ?? 0,
      feelsLike: json['hissedilen'] as int? ?? 0,
      humidity: json['nem'] as int? ?? 0,
      windSpeed: (json['ruzgarMs'] as num? ?? 0).toDouble(),
      pressure: json['basinc'] as int? ?? 0,
      description: json['aciklama'] as String? ?? '',
      iconCode: json['ikon'] as String? ?? 'na',
    );
  }

  CurrentWeather toDomain() {
    return CurrentWeather(
      temperature: temperature,
      feelsLike: feelsLike,
      humidity: humidity,
      windSpeed: windSpeed,
      pressure: pressure,
      description: description,
      iconCode: iconCode,
    );
  }
}

class HourlyForecastDto {
  const HourlyForecastDto({
    required this.hourLabel,
    required this.temperature,
    required this.precipitationProbability,
    required this.iconCode,
  });

  final String hourLabel;
  final int temperature;
  final int precipitationProbability;
  final String iconCode;

  factory HourlyForecastDto.fromJson(Map<String, dynamic> json) {
    return HourlyForecastDto(
      hourLabel: json['saat'] as String? ?? '',
      temperature: json['sicaklik'] as int? ?? 0,
      precipitationProbability: json['yagis'] as int? ?? 0,
      iconCode: json['ikon'] as String? ?? 'na',
    );
  }

  HourlyForecast toDomain() {
    return HourlyForecast(
      hourLabel: hourLabel,
      temperature: temperature,
      precipitationProbability: precipitationProbability,
      iconCode: iconCode,
    );
  }
}

class DailyForecastDto {
  const DailyForecastDto({
    required this.dayLabel,
    required this.minTemperature,
    required this.maxTemperature,
    required this.description,
    required this.iconCode,
  });

  final String dayLabel;
  final int minTemperature;
  final int maxTemperature;
  final String description;
  final String iconCode;

  factory DailyForecastDto.fromJson(Map<String, dynamic> json) {
    return DailyForecastDto(
      dayLabel: json['gun'] as String? ?? '',
      minTemperature: json['min'] as int? ?? 0,
      maxTemperature: json['max'] as int? ?? 0,
      description: json['aciklama'] as String? ?? '',
      iconCode: json['ikon'] as String? ?? 'na',
    );
  }

  DailyForecast toDomain() {
    return DailyForecast(
      dayLabel: dayLabel,
      minTemperature: minTemperature,
      maxTemperature: maxTemperature,
      description: description,
      iconCode: iconCode,
    );
  }
}

class WeatherSearchSuggestionDto {
  const WeatherSearchSuggestionDto({
    required this.city,
    required this.district,
    required this.isGpsCurrentLocation,
  });

  final String city;
  final String district;
  final bool isGpsCurrentLocation;

  factory WeatherSearchSuggestionDto.fromJson(Map<String, dynamic> json) {
    return WeatherSearchSuggestionDto(
      city: json['sehir'] as String? ?? '',
      district: json['ilce'] as String? ?? '',
      isGpsCurrentLocation: json['gps'] as bool? ?? false,
    );
  }

  WeatherSearchSuggestion toDomain() {
    return WeatherSearchSuggestion(
      city: city,
      district: district,
      isGpsCurrentLocation: isGpsCurrentLocation,
    );
  }
}
