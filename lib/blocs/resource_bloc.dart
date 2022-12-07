import 'dart:developer' as dev_tools;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_repository/football_repository.dart';
import 'resource_status.dart';

part 'resource_event.dart';
part 'resource_state.dart';

class ResourceBloc<Resource>
    extends Bloc<ResourceEvent<Resource>, ResourceState<Resource>> {
  ResourceBloc({required this.repository}) : super(ResourceState()) {
    on<ResourceEvent<Resource>>(_mapEventToState);
  }

  final Repository<Resource> repository;

  void _mapEventToState(
      ResourceEvent<Resource> event,
      Emitter<ResourceState<Resource>> emit,) async {

    emit(
      ResourceState(
        status: ResourceStatus.loading,
        resources: [],
      ),
    );

    try {
      final resources = await repository.getResource(event.parameters);
      emit(ResourceState(
        status: ResourceStatus.success,
        resources: resources,
      ));
    } catch (exception) {
      dev_tools.log('Request failed with exception: ${exception}');
      emit(ResourceState(
        status: ResourceStatus.error,
        resources: [],
      ));
    }
  }
}
