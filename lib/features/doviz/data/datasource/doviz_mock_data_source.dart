import 'package:guvenli_sehrim/core/mock/mock_response.dart';
import 'package:guvenli_sehrim/core/mock/mock_scenario.dart';

import '../mock/doviz_mock_source.dart';

class MarketMockDataSource {
  MarketMockDataSource({
    DovizMockSource mockSource = const DovizMockSource(),
    MockScenario defaultScenario = MockScenario.success,
  })  : _mockSource = mockSource,
        _defaultScenario = defaultScenario;

  final DovizMockSource _mockSource;
  final MockScenario _defaultScenario;

  MockResponse<Map<String, dynamic>> getSnapshotPayload() {
    final payload = _mockSource.snapshotPayload;
    switch (_defaultScenario) {
      case MockScenario.success:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T09:08:00+03:00'),
        );
      case MockScenario.offline:
        return MockResponse(
          scenario: _defaultScenario,
          data: payload,
          lastUpdated: DateTime.parse('2026-04-17T08:00:00+03:00'),
          fromCache: true,
        );
      case MockScenario.empty:
        return MockResponse(
          scenario: _defaultScenario,
          data: {
            'sonGuncelleme': 'Veri yok',
            'onecikanlar': <String>[],
            'kurlar': <Map<String, dynamic>>[],
            'trend': <Map<String, dynamic>>[],
          },
          lastUpdated: DateTime.now(),
        );
      case MockScenario.error:
        return MockResponse(
          scenario: _defaultScenario,
          errorMessage: 'Piyasa verileri alınırken bağlantı hatası oluştu.',
          lastUpdated: DateTime.now(),
        );
    }
  }
}
