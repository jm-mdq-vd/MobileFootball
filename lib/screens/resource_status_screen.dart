import 'package:flutter/material.dart';

import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';

class ResourceStatusScreen<T> extends StatelessWidget {
  const ResourceStatusScreen({
    super.key,
    required this.state,
    required this.loaderMessage,
    required this.successWidget,
  });

  final ResourceState<T> state;
  final String loaderMessage;
  final Widget successWidget;

  @override
  Widget build(BuildContext context) {
    if (state.status.isLoading) {
      return ScreenLoader(message: loaderMessage,);
    }

    if (state.status.isSuccess) {
      if (state.resources.isNotEmpty) {
        return successWidget;
      }
    }

    return Container();
  }
}