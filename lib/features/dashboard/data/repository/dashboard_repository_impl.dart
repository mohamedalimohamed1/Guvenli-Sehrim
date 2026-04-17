import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/dashboard/data/datasource/dashboard_mock_data_source.dart';
import 'package:guvenli_sehrim/features/dashboard/data/dto/dashboard_dto.dart';
import 'package:guvenli_sehrim/features/dashboard/domain/model/dashboard_models.dart';
import 'package:guvenli_sehrim/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required DashboardMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final DashboardMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<DashboardSnapshot>>> getDashboardSnapshot() async {
    final response = _mockDataSource.getOverviewPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) {
        final dto = DashboardSnapshotDto.fromJson(payload);
        return dto.toDomain(isOffline: response.fromCache || response.isOffline);
      },
      isEmpty: (snapshot) => snapshot.cards.isEmpty,
      fallbackErrorMessage: 'Dashboard verileri alınamadı.',
    );
  }
}
