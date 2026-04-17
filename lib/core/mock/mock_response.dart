import 'mock_scenario.dart';

class MockResponse<T> {
  const MockResponse({
    required this.scenario,
    this.data,
    this.errorMessage,
    required this.lastUpdated,
    this.fromCache = false,
  });

  final MockScenario scenario;
  final T? data;
  final String? errorMessage;
  final DateTime lastUpdated;
  final bool fromCache;

  bool get isSuccess => scenario == MockScenario.success && data != null;
  bool get isOffline => scenario == MockScenario.offline;
  bool get isError => scenario == MockScenario.error;
}
