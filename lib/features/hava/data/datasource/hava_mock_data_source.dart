import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/hava_mock_source.dart';

class WeatherMockDataSource {
  WeatherMockDataSource({
    HavaMockSource mockSource = const HavaMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final HavaMockSource _mockSource;
  final MockScenario _defaultScenario;

  MockResponse<Map<String, dynamic>> getSnapshotPayload() {
    final payload = _mockSource.snapshotPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T09:05:00+03:00'),
        );
      case MockScenario.offline:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T08:10:00+03:00'),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'sehir': 'İstanbul',
            'ilce': 'Üsküdar',
            'arkaPlan': 'neutral',
            'anlik': {
              'sicaklik': 0,
              'hissedilen': 0,
              'nem': 0,
              'ruzgarMs': 0,
              'basinc': 0,
              'aciklama': 'Veri bekleniyor',
              'ikon': 'na',
            },
            'saatlik': <Map<String, dynamic>>[],
            'besGunluk': <Map<String, dynamic>>[],
            'oneriler': <Map<String, dynamic>>[],
          },
          lastUpdated: DateTime.now(),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Hava durumu verileri güncellenemedi.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
