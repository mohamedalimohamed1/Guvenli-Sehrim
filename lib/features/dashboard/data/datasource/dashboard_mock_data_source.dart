import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/dashboard_mock_source.dart';

class DashboardMockDataSource {
  DashboardMockDataSource({
    DashboardMockSource mockSource = const DashboardMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final DashboardMockSource _mockSource;
  final MockScenario _defaultScenario;

  MockResponse<Map<String, dynamic>> getOverviewPayload() {
    final payload = _mockSource.overviewPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse(payload['sonGuncelleme'] as String),
        );
      case MockScenario.offline:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse(payload['sonGuncelleme'] as String),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'konum': {'sehir': 'İstanbul', 'ilce': 'Üsküdar'},
            'sonGuncelleme': '2026-04-17T06:12:00+03:00',
            'kartlar': <Map<String, dynamic>>[],
            'uyarilar': <Map<String, dynamic>>[],
          },
          lastUpdated: DateTime.parse('2026-04-17T06:12:00+03:00'),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Dashboard verileri şu anda alınamıyor.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
