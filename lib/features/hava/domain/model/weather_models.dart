class WeatherSnapshot {
  const WeatherSnapshot({
    required this.city,
    required this.district,
    required this.current,
    required this.hourly,
    required this.daily,
    required this.searchSuggestions,
    required this.backgroundKey,
  });

  final String city;
  final String district;
  final CurrentWeather current;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;
  final List<WeatherSearchSuggestion> searchSuggestions;
  final String backgroundKey;
}

class CurrentWeather {
  const CurrentWeather({
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
}

class HourlyForecast {
  const HourlyForecast({
    required this.hourLabel,
    required this.temperature,
    required this.precipitationProbability,
    required this.iconCode,
  });

  final String hourLabel;
  final int temperature;
  final int precipitationProbability;
  final String iconCode;
}

class DailyForecast {
  const DailyForecast({
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
}

class WeatherSearchSuggestion {
  const WeatherSearchSuggestion({
    required this.city,
    required this.district,
    required this.isGpsCurrentLocation,
  });

  final String city;
  final String district;
  final bool isGpsCurrentLocation;
}
