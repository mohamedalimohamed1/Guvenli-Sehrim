import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';

abstract class DovizRepository {
  Future<Result<RepositoryData<MarketsSnapshot>>> getMarketsSnapshot();
}
