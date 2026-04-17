import 'package:flutter/foundation.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';
import 'package:guvenli_sehrim/core/utils/view_state.dart';
import 'package:guvenli_sehrim/features/deprem/domain/model/earthquake_models.dart';
import 'package:guvenli_sehrim/features/deprem/domain/repository/deprem_repository.dart';

class DepremProvider extends ChangeNotifier {
  DepremProvider(this.repository);

  final DepremRepository repository;

  ViewState<EarthquakeFeed> _feedState = const ViewState.initial();
  EarthquakeDetail? _selectedDetail;
  String? _selectedEventId;
  String? _selectedFilterCode;
  String? _detailErrorMessage;

  ViewState<EarthquakeFeed> get feedState => _feedState;
  EarthquakeDetail? get selectedDetail => _selectedDetail;
  String? get selectedEventId => _selectedEventId;
  String? get selectedFilterCode => _selectedFilterCode;
  String? get detailErrorMessage => _detailErrorMessage;

  Future<void> load() async {
    _feedState = ViewState.loading(
      previousData: _feedState.data,
      lastUpdated: _feedState.lastUpdated,
      isOffline: _feedState.isOffline,
    );
    notifyListeners();

    final result = await repository.getEarthquakeFeed();
    _feedState = _mapFeedResult(result);
    notifyListeners();

    final events = _feedState.data?.events ?? const <EarthquakeEvent>[];
    if (_feedState.status == ViewStatus.success && events.isNotEmpty) {
      final filters = _feedState.data!.filterOptions;
      _selectedFilterCode ??= filters.isNotEmpty ? filters.first.code : null;
      await selectEvent(events.first.id);
    }
  }

  Future<void> refresh() => load();

  Future<void> selectEvent(String eventId) async {
    _selectedEventId = eventId;
    _detailErrorMessage = null;
    notifyListeners();

    final result = await repository.getEarthquakeDetail(eventId);
    if (result is ResultFailure<RepositoryData<EarthquakeDetail>>) {
      _selectedDetail = null;
      _detailErrorMessage = result.failure.message;
      notifyListeners();
      return;
    }

    final payload = (result as ResultSuccess<RepositoryData<EarthquakeDetail>>).data;
    _selectedDetail = payload.data;
    notifyListeners();
  }

  void selectFilter(String filterCode) {
    _selectedFilterCode = filterCode;
    notifyListeners();
  }

  ViewState<EarthquakeFeed> _mapFeedResult(
    Result<RepositoryData<EarthquakeFeed>> result,
  ) {
    if (result is ResultFailure<RepositoryData<EarthquakeFeed>>) {
      return ViewState.error(
        result.failure,
        previousData: _feedState.data,
        lastUpdated: _feedState.lastUpdated,
        isOffline: _feedState.isOffline,
      );
    }

    final payload = (result as ResultSuccess<RepositoryData<EarthquakeFeed>>).data;
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
      isOffline: payload.isFromCache,
    );
  }
}
