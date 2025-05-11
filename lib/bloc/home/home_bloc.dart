import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart' show Box;
import 'package:hot_note/core/utils/show_toast.dart';
import 'package:hot_note/data/models/note.dart';
import 'package:hot_note/data/services/database/local_db_service.dart';
import 'package:hot_note/screens/note_add_screen.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalDbService _localDbService;
  final Box<Note> _box;
  List<Note> notes = [];
  HomeBloc(LocalDbService localDbService, Box<Note> box)
    : _localDbService = localDbService,
      _box = box,
      super(HomeInitial()) {
    on<AddNoteEvent>(_addNote);
    on<GetNotesEvent>(_getNotes);
    on<DeleteNoteEvent>(_deleteNoteEvent);
  }
  _addNote(AddNoteEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      notes.clear();

      final int autoId = _box.isNotEmpty ? _box.keys.last + 1 : 1;
      final note = Note(
        id: autoId,
        title: event.note.title,
        desc: event.note.desc,
        isUploaded: true,
      );
      await _localDbService.addNote(note);
      notes = _localDbService.getAllNotes();
      if (notes.isNotEmpty) {
        emit(HomeSuccess(notes));
      } else {
        emit(HomeFailure("Something Wrong! try agin"));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  _getNotes(GetNotesEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      notes.clear();
      notes = _localDbService.getAllNotes();
      if (notes.isNotEmpty) {
        emit(HomeSuccess(notes));
      } else {
        emit(HomeFailure("Something Wrong! try agin"));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  _deleteNoteEvent(DeleteNoteEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      notes.clear();
      await _localDbService.deleteNote(event.noteId);
      notes = _localDbService.getAllNotes();
      if (notes.isNotEmpty) {
        emit(HomeSuccess(notes));
      } else {
        emit(HomeFailure("Something Wrong! try agin"));
      }
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
