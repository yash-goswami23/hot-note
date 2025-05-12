import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hot_note/data/models/note.dart';
import 'package:hot_note/data/services/database/firestore_service.dart';
import 'package:hot_note/data/services/database/local_db_service.dart';
import 'package:hot_note/data/services/database/note_queue_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalDbService _localDbService;
  final Box<Note> _box;
  final FirestoreService _firestoreService;
  late final NoteQueueService _noteQueueService;

  List<Note> notes = [];

  HomeBloc(this._localDbService, this._box, this._firestoreService)
    : super(HomeInitial()) {
    on<AddNoteEvent>(_addNote);
    on<GetNotesEvent>(_getNotes);
    on<DeleteAllLcoalNotes>(_deleteAllLcoalNotes);
  }

  void setQueueService(NoteQueueService queueService) {
    _noteQueueService = queueService;
  }

  Future<void> _addNote(AddNoteEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final int autoId = _box.isNotEmpty ? _box.keys.last + 1 : 1;
      final note = Note(
        id: autoId,
        title: event.note.title,
        desc: event.note.desc,
        isUploaded: false,
      );

      await _localDbService.addNote(note);
      _noteQueueService.addToQueue(note);

      notes = _localDbService.getAllNotes();
      emit(HomeSuccess(notes));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  Future<void> _getNotes(GetNotesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Optional: you can re-fetch from Firestore here too
      final updatedNotes = _localDbService.getAllNotes();
      emit(HomeSuccess(updatedNotes));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  _deleteAllLcoalNotes(
    DeleteAllLcoalNotes event,
    Emitter<HomeState> emit,
  ) async {
    await _localDbService.deleteNote();
  }
}
