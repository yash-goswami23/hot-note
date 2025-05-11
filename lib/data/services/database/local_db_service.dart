import 'package:hive/hive.dart';
import 'package:hot_note/data/models/note.dart';

class LocalDbService {
  final Box<Note> _box;

  LocalDbService(this._box);

  // Insert a Note
  Future<void> addNote(Note note) async {
    await _box.put(note.id, note); // Uses ID as key
  }

  // Retrieve a Note
  Note? getNote(int id) {
    return _box.get(id);
  }

  // Get All Notes
  List<Note> getAllNotes() {
    return _box.values.toList();
  }

  // Delete a Note
  Future<void> deleteNote(int id) async {
    await _box.delete(id);
  }
}
