import 'failure.dart';

enum ViewStatus {
  initial,
  loading,
  success,
  empty,
  error,
}

class ViewState<T> {
  const ViewState({
    required this.status,
    this.data,
    this.failure,
    this.lastUpdated,
    this.isOffline = false,
  });

  const ViewState.initial() : this(status: ViewStatus.initial);

  const ViewState.loading({
    T? previousData,
    DateTime? lastUpdated,
    bool isOffline = false,
  }) : this(
          status: ViewStatus.loading,
          data: previousData,
          lastUpdated: lastUpdated,
          isOffline: isOffline,
        );

  const ViewState.success(
    T value, {
    DateTime? lastUpdated,
    bool isOffline = false,
  }) : this(
          status: ViewStatus.success,
          data: value,
          lastUpdated: lastUpdated,
          isOffline: isOffline,
        );

  const ViewState.empty({
    T? previousData,
    DateTime? lastUpdated,
    bool isOffline = false,
  }) : this(
          status: ViewStatus.empty,
          data: previousData,
          lastUpdated: lastUpdated,
          isOffline: isOffline,
        );

  const ViewState.error(
    Failure error, {
    T? previousData,
    DateTime? lastUpdated,
    bool isOffline = false,
  }) : this(
          status: ViewStatus.error,
          failure: error,
          data: previousData,
          lastUpdated: lastUpdated,
          isOffline: isOffline,
        );

  final ViewStatus status;
  final T? data;
  final Failure? failure;
  final DateTime? lastUpdated;
  final bool isOffline;

  bool get hasData => data != null;
}
