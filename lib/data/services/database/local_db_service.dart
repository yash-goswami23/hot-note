import 'package:hive/hive.dart';
import 'package:hot_note/data/models/note.dart';

class LocalDbService {
  final Box<Note> _box;

  LocalDbService(Box<Note> box) : _box = box;

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

  Future<void> updateNote(Note note) async {
    Note? existingNote = _box.get(note.id); // Retrieve the existing note
    if (existingNote != null) {
      Note updatedNote = Note(
        id: note.id,
        title: note.title,
        desc: note.desc,
        isUploaded: note.isUploaded,
      );
      await _box.put(note.id, updatedNote); // Save updated note back to Hive
    } else {
      throw ("Error: Note not found");
    }
  }

  // Delete a Note
  Future<void> deleteNote() async {
    await _box.deleteFromDisk();
    
  }
}
