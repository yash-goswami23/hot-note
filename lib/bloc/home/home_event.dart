part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class AddNoteEvent extends HomeEvent {
  final Note note;
  const AddNoteEvent(this.note);

  @override
  List<Object> get props => [note];
}

class GetNotesEvent extends HomeEvent {}

class DeleteAllLcoalNotes extends HomeEvent {}
