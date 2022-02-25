part of 'wehter_cubit.dart';

@immutable
abstract class WehterState {}

class WehterInitial extends WehterState {}

class WehterLoading extends WehterState {}

class WehterLoaded extends WehterState {
  WeatherModel model;
  WehterLoaded(this.model);
}

class WehterError extends WehterState {}
