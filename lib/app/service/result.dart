class Result<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  Result.success(this.data)
      : isSuccess = true,
        error = null;
  Result.failure(this.error)
      : isSuccess = false,
        data = null;

  R fold<R>(R Function(T data) onSuccess, R Function(String error) onFailure) {
    if (isSuccess) {
      return onSuccess(data!);
    } else {
      return onFailure(error!);
    }
  }
}
