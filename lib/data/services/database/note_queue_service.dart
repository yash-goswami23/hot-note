import 'dart:async';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_note/data/models/note.dart';
import 'package:hot_note/data/services/database/firestore_service.dart';
import 'package:hot_note/data/services/database/local_db_service.dart';
import 'package:hot_note/bloc/home/home_bloc.dart';

class NoteQueueService {
  final FirestoreService firestoreService;
  final LocalDbService localDbService;
  final HomeBloc homeBloc;

  final Queue<Note> _queue = Queue<Note>();
  bool _isProcessing = false;

  NoteQueueService({
    required this.firestoreService,
    required this.homeBloc,
    required this.localDbService,
  });

  void addToQueue(Note note) {
    _queue.add(note);
    _startProcessing();
  }

  void _startProcessing() {
    if (_isProcessing) return;

    _isProcessing = true;

    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (_queue.isEmpty) {
        timer.cancel();
        _isProcessing = false;
        return;
      }

      final note = _queue.removeFirst();
      try {
        final success = await firestoreService.saveNote(note);
        if (success) {
          final updated = note.copyWith(isUploaded: true);
          await localDbService.updateNote(updated);
          homeBloc.add(GetNotesEvent());
        }
      } catch (e) {
        print("❌ Upload failed, re-queued: ${note.title}");
        _queue.addLast(note);
      }
    });
  }
}
