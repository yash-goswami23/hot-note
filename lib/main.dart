import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hot_note/firebase_options.dart';
import 'package:hot_note/data/models/note.dart';
import 'package:hot_note/data/services/auth/auth_service.dart';
import 'package:hot_note/data/services/database/firestore_service.dart';
import 'package:hot_note/data/services/database/local_db_service.dart';
import 'package:hot_note/data/services/database/note_queue_service.dart';
import 'package:hot_note/bloc/auth/auth_bloc.dart';
import 'package:hot_note/bloc/home/home_bloc.dart';
import 'package:hot_note/core/theme/app_theme.dart';
import 'package:hot_note/core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  final noteBox = await Hive.openBox<Note>('notesBox');

  runApp(MainApp(noteBox: noteBox));
}

class MainApp extends StatefulWidget {
  final Box<Note> noteBox;
  const MainApp({super.key, required this.noteBox});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final FirebaseAuth _auth;
  late final AuthService _authService;
  late final FirestoreService _firestoreService;
  late final LocalDbService _localDbService;
  late final NoteQueueService _noteQueueService;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _authService = AuthService(firebaseAuth: _auth);
    _firestoreService = FirestoreService();
    _localDbService = LocalDbService(widget.noteBox);

    _homeBloc = HomeBloc(
      _localDbService,
      widget.noteBox,
      _firestoreService,
    );

    _noteQueueService = NoteQueueService(
      firestoreService: _firestoreService,
      homeBloc: _homeBloc,
      localDbService: _localDbService,
    );

    _homeBloc.setQueueService(_noteQueueService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(_authService)),
        BlocProvider<HomeBloc>.value(value: _homeBloc),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRoutes.router(_auth.currentUser),
      ),
    );
  }
}
