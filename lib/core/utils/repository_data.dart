class RepositoryData<T> {
  const RepositoryData({
    required this.data,
    required this.lastUpdated,
    this.isFromCache = false,
    this.isEmpty = false,
  });

  final T data;
  final DateTime lastUpdated;
  final bool isFromCache;
  final bool isEmpty;
}
