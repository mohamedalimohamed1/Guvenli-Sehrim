import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';

abstract class HavaRepository {
  Future<Result<RepositoryData<WeatherSnapshot>>> getWeatherSnapshot();
}
