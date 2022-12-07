enum ResourceStatus { initial, success, error, loading }

extension ResourceStatusX on ResourceStatus {
  bool get isInitial => this == ResourceStatus.initial;
  bool get isSuccess => this == ResourceStatus.success;
  bool get isError => this == ResourceStatus.error;
  bool get isLoading => this == ResourceStatus.loading;
}