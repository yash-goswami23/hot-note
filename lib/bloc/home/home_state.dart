part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Note> notes;
  HomeSuccess(this.notes);
}

class HomeFailure extends HomeState {
  final String msg;
  HomeFailure(this.msg);
}

class HomeLoading extends HomeState {}
