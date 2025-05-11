import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hot_note/bloc/auth/auth_bloc.dart';
import 'package:hot_note/core/routes/app_routes.dart';
import 'package:hot_note/core/theme/app_theme.dart';
import 'package:hot_note/data/services/auth_service.dart';
import 'package:hot_note/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AuthService _authService;

  late final FirebaseAuth _firebaseAuth;
  @override
  void initState() {
    super.initState();
    _firebaseAuth = FirebaseAuth.instance;
    _authService = AuthService(firebaseAuth: _firebaseAuth);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => AuthBloc(_authService),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        routerConfig: AppRoutes.router(_authService.checkUserLogined()), // Set GoRouter config
      ),
    );
  }
}
