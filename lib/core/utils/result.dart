import 'package:guvenli_sehrim/core/utils/failure.dart';

abstract class Result<T> {
  const Result();
}

class ResultSuccess<T> extends Result<T> {
  const ResultSuccess(this.data);

  final T data;
}

class ResultFailure<T> extends Result<T> {
  const ResultFailure(this.failure);

  final Failure failure;
}
