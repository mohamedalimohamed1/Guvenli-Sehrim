import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/ayarlar_mock_source.dart';

class SettingsMockDataSource {
  SettingsMockDataSource({
    AyarlarMockSource mockSource = const AyarlarMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final AyarlarMockSource _mockSource;
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
          lastUpdated: DateTime.parse('2026-04-17T08:52:00+03:00'),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'tema': 'system',
            'bildirimler': {'aktif': false, 'depremEsik': 0, 'aqiEsik': 0},
            'veri': {'yenilemeDakika': 15, 'cacheMb': 0, 'secenekler': <int>[]},
          },
          lastUpdated: DateTime.now(),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Ayarlar okunurken yerel depolama hatası oluştu.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
