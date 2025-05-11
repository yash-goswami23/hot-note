import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hot_note/bloc/auth/auth_bloc.dart';
import 'package:hot_note/bloc/home/home_bloc.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_theme.dart';
import 'package:hot_note/data/models/note.dart';
import 'package:hot_note/data/services/auth/auth_service.dart';
import 'package:hot_note/data/services/database/local_db_service.dart';
import 'package:hot_note/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter(); // Initialize Hive storage

  Hive.registerAdapter(NoteAdapter()); // Register the adapter

  final Box<Note> box = await Hive.openBox<Note>(
    'notesBox',
  ); // Open the Hive Box
  runApp(MainApp(box: box));
}

class MainApp extends StatefulWidget {
  final Box<Note> box;
  const MainApp({super.key, required this.box});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthService _authService;
  late final FirebaseAuth _firebaseAuth;
  late final Box<Note> _box;
  late final LocalDbService _localDbService;
  @override
  void initState() {
    super.initState();
    _box = widget.box;
    _localDbService = LocalDbService(_box);
    _firebaseAuth = FirebaseAuth.instance;
    _authService = AuthService(firebaseAuth: _firebaseAuth);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(_authService)),
        BlocProvider(create: (_) => HomeBloc(_localDbService, _box)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRoutes.router(
          _authService.checkUserLogined(),
        ), // Set GoRouter config
      ),
    );
  }
}
