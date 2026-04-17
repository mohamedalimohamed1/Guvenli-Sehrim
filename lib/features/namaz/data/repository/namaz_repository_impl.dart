import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/namaz/data/datasource/namaz_mock_data_source.dart';
import 'package:guvenli_sehrim/features/namaz/data/dto/namaz_dto.dart';
import 'package:guvenli_sehrim/features/namaz/domain/model/prayer_models.dart';
import 'package:guvenli_sehrim/features/namaz/domain/repository/namaz_repository.dart';

class NamazRepositoryImpl implements NamazRepository {
  NamazRepositoryImpl({
    required PrayerMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final PrayerMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<PrayerTimesSnapshot>>> getPrayerTimes() async {
    final response = _mockDataSource.getSnapshotPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) => PrayerTimesSnapshotDto.fromJson(payload).toDomain(),
      isEmpty: (snapshot) => snapshot.todayTimes.isEmpty,
      fallbackErrorMessage: 'Namaz vakitleri alınamadı.',
    );
  }
}
