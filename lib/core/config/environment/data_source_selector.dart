import 'app_environment.dart';

class DataSourceSelector {
  const DataSourceSelector._();

  static T resolve<T>({
    required T mock,
    required T live,
  }) {
    return AppEnvironment.useMockData ? mock : live;
  }
}
