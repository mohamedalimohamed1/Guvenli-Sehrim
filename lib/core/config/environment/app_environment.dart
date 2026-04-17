import 'data_mode.dart';

class AppEnvironment {
  const AppEnvironment._();

  static DataMode dataMode = DataMode.mock;

  static bool get useMockData => dataMode == DataMode.mock;

  static void setDataMode(DataMode mode) {
    dataMode = mode;
  }
}
