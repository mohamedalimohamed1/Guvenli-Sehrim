import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/dashboard/domain/model/dashboard_models.dart';
import 'package:guvenli_sehrim/features/dashboard/domain/repository/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  DashboardProvider(this.repository);

  final DashboardRepository repository;

  ViewState<DashboardSnapshot> _state = const ViewState.initial();

  ViewState<DashboardSnapshot> get state => _state;

  Future<void> load() async {
    _state = ViewState.loading(
      previousData: _state.data,
      lastUpdated: _state.lastUpdated,
      isOffline: _state.isOffline,
    );
    notifyListeners();

    final result = await repository.getDashboardSnapshot();
    _state = _mapResult(result);
    notifyListeners();
  }

  Future<void> refresh() => load();

  ViewState<DashboardSnapshot> _mapResult(
    Result<RepositoryData<DashboardSnapshot>> result,
  ) {
    if (result is ResultFailure<RepositoryData<DashboardSnapshot>>) {
      return ViewState.error(
        result.failure,
        previousData: _state.data,
        lastUpdated: _state.lastUpdated,
        isOffline: _state.isOffline,
      );
    }

    final payload = (result as ResultSuccess<RepositoryData<DashboardSnapshot>>).data;
    if (payload.isEmpty) {
      return ViewState.empty(
        previousData: payload.data,
        lastUpdated: payload.lastUpdated,
        isOffline: payload.isFromCache,
      );
    }

    return ViewState.success(
      payload.data,
      lastUpdated: payload.lastUpdated,
      isOffline: payload.isFromCache || payload.data.isOffline,
    );
  }
}
