import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/namaz_mock_source.dart';

class PrayerMockDataSource {
  PrayerMockDataSource({
    NamazMockSource mockSource = const NamazMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final NamazMockSource _mockSource;
  final MockScenario _defaultScenario;

  MockResponse<Map<String, dynamic>> getSnapshotPayload() {
    final payload = _mockSource.snapshotPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T09:01:00+03:00'),
        );
      case MockScenario.offline:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T04:30:00+03:00'),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'sehir': 'İstanbul',
            'siradakiVakit': {'ad': 'Veri yok', 'saat': '--:--', 'geriSayim': '00:00:00'},
            'bugun': <Map<String, dynamic>>[],
            'haftalik': <Map<String, dynamic>>[],
          },
          lastUpdated: DateTime.now(),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Namaz vakitleri servisine ulaşılamadı.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
