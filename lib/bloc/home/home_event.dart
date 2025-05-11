part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

final class AddNoteEvent extends HomeEvent {
  final Note note;
  AddNoteEvent(this.note);
}

final class GetNotesEvent extends HomeEvent {}

final class DeleteNoteEvent extends HomeEvent {
  final int noteId;
  DeleteNoteEvent(this.noteId);
}
