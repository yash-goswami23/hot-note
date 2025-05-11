import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_note/screens/auth_screen.dart';
import 'package:hot_note/screens/home_screen.dart';
import 'package:hot_note/screens/note_add_screen.dart';

class AppRoutes {
  static final String dashboard = '/dashboard';
  static final String addNote = '/addnote';
  static final String auth = '/';
  static GoRouter router(User? user) => GoRouter(
    initialLocation: user != null ? dashboard : auth,
    routes: [
      GoRoute(path: auth, builder: (context, state) => AuthScreen()),
      GoRoute(path: dashboard, builder: (context, state) => HomeScreen()),
      GoRoute(path: addNote, builder: (context, state) => NoteAddScreen()),
    ],
  );
}
