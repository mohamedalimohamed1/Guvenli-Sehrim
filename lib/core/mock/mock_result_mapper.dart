import 'package:guvenli_sehrim/core/utils/failure.dart';
import 'package:guvenli_sehrim/core/utils/repository_data.dart';
import 'package:guvenli_sehrim/core/utils/result.dart';

import 'mock_response.dart';

Result<RepositoryData<R>> mapMockResponse<T, R>({
  required MockResponse<T> response,
  required R Function(T data) transform,
  required bool Function(R data) isEmpty,
  String fallbackErrorMessage = 'Veri alınamadı.',
}) {
  if (response.data == null) {
    return ResultFailure(
      Failure(message: response.errorMessage ?? fallbackErrorMessage),
    );
  }

  final transformed = transform(response.data as T);
  return ResultSuccess(
    RepositoryData<R>(
      data: transformed,
      lastUpdated: response.lastUpdated,
      isFromCache: response.fromCache || response.isOffline,
      isEmpty: isEmpty(transformed),
    ),
  );
}
