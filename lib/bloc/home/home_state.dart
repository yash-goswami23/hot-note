part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Note> notes;
  const HomeSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

class HomeFailure extends HomeState {
  final String msg;
  const HomeFailure(this.msg);

  @override
  List<Object> get props => [msg];
}
