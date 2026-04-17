import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/deprem_mock_source.dart';

class EarthquakeMockDataSource {
  EarthquakeMockDataSource({
    DepremMockSource mockSource = const DepremMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final DepremMockSource _mockSource;
  final MockScenario _defaultScenario;

  MockResponse<Map<String, dynamic>> getFeedPayload() {
    final payload = _mockSource.feedPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse(payload['olusturmaZamani'] as String),
        );
      case MockScenario.offline:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse(payload['olusturmaZamani'] as String),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'olusturmaZamani': payload['olusturmaZamani'],
            'ozet': {
              'son24SaatAdet': 0,
              'enBuyukMagnitud': 0,
              'enYakinSehir': 'İstanbul',
              'ortalamaDerinlikKm': 0,
            },
            'filtreler': payload['filtreler'],
            'depremler': <Map<String, dynamic>>[],
          },
          lastUpdated: DateTime.parse(payload['olusturmaZamani'] as String),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'AFAD deprem verisi alınırken beklenmeyen hata oluştu.',
          lastUpdated: DateTime.now(),
        );
    }
  }

  MockResponse<Map<String, dynamic>> getDetailPayload(String eventId) {
    final detail = _mockSource.detailPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
      case MockScenario.offline:
        if (detail['id'] != eventId) {
          return MockResponse(
            scenario: MockScenario.error,
            errorMessage: 'Seçili deprem detayı bulunamadı.',
            lastUpdated: DateTime.now(),
          );
        }
        return MockResponse(
          scenario: _defaultScenario,
          data: detail,
          lastUpdated: DateTime.parse(
            _mockSource.feedPayload['olusturmaZamani'] as String,
          ),
          fromCache: _defaultScenario == MockScenario.offline,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: <String, dynamic>{},
          lastUpdated: DateTime.now(),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Deprem detay ekranı için veri yüklenemedi.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
