import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';

abstract class AqiRepository {
  Future<Result<RepositoryData<AirQualitySnapshot>>> getAqiSnapshot();
}
