import 'package:guvenli_sehrim/core/mock/mock_result_mapper.dart';
import 'package:guvenli_sehrim/core/utils/failure.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/deprem/data/datasource/deprem_mock_data_source.dart';
import 'package:guvenli_sehrim/features/deprem/data/dto/deprem_dto.dart';
import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';
import 'package:guvenli_sehrim/features/deprem/domain/repository/deprem_repository.dart';

class DepremRepositoryImpl implements DepremRepository {
  DepremRepositoryImpl({
    required EarthquakeMockDataSource mockDataSource,
  }) : _mockDataSource = mockDataSource;

  final EarthquakeMockDataSource _mockDataSource;

  @override
  Future<Result<RepositoryData<EarthquakeFeed>>> getEarthquakeFeed() async {
    final response = _mockDataSource.getFeedPayload();
    return mapMockResponse(
      response: response,
      transform: (payload) => EarthquakeFeedDto.fromJson(payload).toDomain(),
      isEmpty: (feed) => feed.events.isEmpty,
      fallbackErrorMessage: 'Deprem akışı alınamadı.',
    );
  }

  @override
  Future<Result<RepositoryData<EarthquakeDetail>>> getEarthquakeDetail(
    String eventId,
  ) async {
    final feedResult = await getEarthquakeFeed();
    if (feedResult is ResultFailure<RepositoryData<EarthquakeFeed>>) {
      return ResultFailure(feedResult.failure);
    }

    final feed = (feedResult as ResultSuccess<RepositoryData<EarthquakeFeed>>).data.data;
    EarthquakeEvent? selectedEvent;
    for (final event in feed.events) {
      if (event.id == eventId) {
        selectedEvent = event;
        break;
      }
    }
    if (selectedEvent == null) {
      return const ResultFailure(
        Failure(message: 'Seçili deprem detayı bulunamadı.'),
      );
    }

    final response = _mockDataSource.getDetailPayload(eventId);
    if (response.data == null || response.data!.isEmpty) {
      return ResultFailure(
        Failure(message: response.errorMessage ?? 'Deprem detayı bulunamadı.'),
      );
    }

    final dto = EarthquakeDetailDto.fromJson(response.data!);
    return ResultSuccess(
      RepositoryData(
        data: dto.toDomain(selectedEvent),
        lastUpdated: response.lastUpdated,
        isFromCache: response.fromCache || response.isOffline,
      ),
    );
  }
}
