import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/ayarlar/data/datasource/ayarlar_mock_data_source.dart';
import 'package:guvenli_sehrim/features/ayarlar/data/dto/ayarlar_dto.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/model/settings_models.dart';
import 'package:guvenli_sehrim/features/ayarlar/domain/repository/ayarlar_repository.dart';

class AyarlarRepositoryImpl implements AyarlarRepository {
  AyarlarRepositoryImpl({
    required SettingsMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final SettingsMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<SettingsSnapshot>>> getSettings() async {
    final response = _mockDataSource.getSnapshotPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) => SettingsSnapshotDto.fromJson(payload).toDomain(),
      isEmpty: (snapshot) => snapshot.availableIntervals.isEmpty,
      fallbackErrorMessage: 'Ayarlar okunamadı.',
    );
  }
}
