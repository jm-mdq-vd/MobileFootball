part of 'resource_bloc.dart';

class ResourceState<Resource> extends Equatable {
  const ResourceState({
    this.status = ResourceStatus.initial,
    List<Resource>? resources,
  }) : resources = resources ?? const [];

  final List<Resource> resources;
  final ResourceStatus status;

  @override
  List<Object?> get props => [status, resources,];

  ResourceState copyWith({
    List<Resource>? resources,
    ResourceStatus? status,
  }) {
    return ResourceState(
      resources: resources ?? this.resources,
      status: status ?? this.status,
    );
  }
}