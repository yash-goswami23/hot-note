import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_note/data/models/note.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> saveNote(Note note) async {
    final user = _auth.currentUser;
    if (user == null) {
      return false;
    }

    try {
      final docRef = _firestore.collection("notes").doc("${user.uid}_${note.id}");
      await docRef.set({
        'id': note.id,
        'title': note.title,
        'desc': note.desc,
        'isUploaded': true,
        'userEmail': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Note>> fetchNotes() async {
    final user = _auth.currentUser;
    if (user == null) return [];

    final snapshot = await _firestore
        .collection("notes")
        .where("userEmail", isEqualTo: user.email)
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return Note(
        id: data['id'],
        title: data['title'],
        desc: data['desc'],
        isUploaded: data['isUploaded'] ?? true,
      );
    }).toList();
  }
}
