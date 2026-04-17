import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/hava/data/datasource/hava_mock_data_source.dart';
import 'package:guvenli_sehrim/features/hava/data/dto/hava_dto.dart';
import 'package:guvenli_sehrim/features/hava/domain/model/weather_models.dart';
import 'package:guvenli_sehrim/features/hava/domain/repository/hava_repository.dart';

class HavaRepositoryImpl implements HavaRepository {
  HavaRepositoryImpl({
    required WeatherMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final WeatherMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<WeatherSnapshot>>> getWeatherSnapshot() async {
    final response = _mockDataSource.getSnapshotPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) => WeatherSnapshotDto.fromJson(payload).toDomain(),
      isEmpty: (snapshot) => snapshot.hourly.isEmpty && snapshot.daily.isEmpty,
      fallbackErrorMessage: 'Hava durumu alınamadı.',
    );
  }
}
