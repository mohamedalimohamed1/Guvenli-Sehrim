import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/features/dashboard/domain/model/dashboard_models.dart';

abstract class DashboardRepository {
  Future<Result<RepositoryData<DashboardSnapshot>>> getDashboardSnapshot();
}
