part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  NavigationEvent({required this.parameters,});

  final Map<String, dynamic> parameters;

  @override
  List<Object?> get props => [];
}

class GoToLeague extends NavigationEvent {
  GoToLeague({required super.parameters});
}

class GoToSeasonSelection extends NavigationEvent {
  GoToSeasonSelection({required super.parameters});
}

class GoToMainScreen extends NavigationEvent {
  GoToMainScreen({required super.parameters});
}