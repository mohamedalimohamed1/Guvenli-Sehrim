import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/doviz/data/datasource/doviz_mock_data_source.dart';
import 'package:guvenli_sehrim/features/doviz/data/dto/doviz_dto.dart';
import 'package:guvenli_sehrim/features/doviz/domain/model/market_models.dart';
import 'package:guvenli_sehrim/features/doviz/domain/repository/doviz_repository.dart';

class DovizRepositoryImpl implements DovizRepository {
  DovizRepositoryImpl({
    required MarketMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final MarketMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<MarketsSnapshot>>> getMarketsSnapshot() async {
    final response = _mockDataSource.getSnapshotPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) => MarketsSnapshotDto.fromJson(payload).toDomain(),
      isEmpty: (snapshot) => snapshot.allQuotes.isEmpty,
      fallbackErrorMessage: 'Piyasa verileri alınamadı.',
    );
  }
}
