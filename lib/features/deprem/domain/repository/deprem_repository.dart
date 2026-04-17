import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';

abstract class DepremRepository {
  Future<Result<RepositoryData<EarthquakeFeed>>> getEarthquakeFeed();
  Future<Result<RepositoryData<EarthquakeDetail>>> getEarthquakeDetail(String eventId);
}
