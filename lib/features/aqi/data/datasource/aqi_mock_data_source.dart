import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/aqi_mock_source.dart';

class AirQualityMockDataSource {
  AirQualityMockDataSource({
    AqiMockSource mockSource = const AqiMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final AqiMockSource _mockSource;
  final MockScenario _defaultScenario;

  MockResponse<Map<String, dynamic>> getSnapshotPayload() {
    final payload = _mockSource.snapshotPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T09:00:00+03:00'),
        );
      case MockScenario.offline:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T07:45:00+03:00'),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'sehir': 'İstanbul',
            'anaIstasyon': 'Veri yok',
            'aqi': 0,
            'kategori': 'Bilinmiyor',
            'renk': '#BDBDBD',
            'oneri': 'İstasyon verisi henüz hazır değil.',
            'trend': <Map<String, dynamic>>[],
            'istasyonlar': <Map<String, dynamic>>[],
          },
          lastUpdated: DateTime.now(),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Hava kalitesi istasyonları şu anda yanıt vermiyor.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
