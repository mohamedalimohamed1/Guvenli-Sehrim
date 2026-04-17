import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/aqi/data/datasource/aqi_mock_data_source.dart';
import 'package:guvenli_sehrim/features/aqi/data/dto/aqi_dto.dart';
import 'package:guvenli_sehrim/features/aqi/domain/model/air_quality_models.dart';
import 'package:guvenli_sehrim/features/aqi/domain/repository/aqi_repository.dart';

class AqiRepositoryImpl implements AqiRepository {
  AqiRepositoryImpl({
    required AirQualityMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final AirQualityMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<AirQualitySnapshot>>> getAqiSnapshot() async {
    final response = _mockDataSource.getSnapshotPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) => AirQualitySnapshotDto.fromJson(payload).toDomain(),
      isEmpty: (snapshot) => snapshot.stations.isEmpty,
      fallbackErrorMessage: 'Hava kalitesi alınamadı.',
    );
  }
}
