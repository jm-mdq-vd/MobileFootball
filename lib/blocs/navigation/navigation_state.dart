part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class InCountrySelection extends NavigationState {}
class InLeagueSelection extends NavigationState {}
class InSeasonSelection extends NavigationState {}
class InMainScreen extends NavigationState {}