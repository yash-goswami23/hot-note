import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hot_note/data/services/auth/auth_service.dart';

import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;
  AuthBloc(AuthService authService)
    : _authService = authService,
      super(AuthInitial()) {
    on<AuthSignIn>(_authSignIn);
    on<CheckIsAuthenticated>(_checkIsAuthenticated);
    on<Logout>(_logout);
  }
  _authSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(Authloading());
    try {
      final user = await _authService.userAuth(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess(user));
      } 
      else {
        emit(AuthFailure("Invalid email or password"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  _logout(Logout event, Emitter<AuthState> emit) {
    emit(Authloading());
    try {
      _authService.logout();
      emit(AuthSuccess(null));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  _checkIsAuthenticated(
    CheckIsAuthenticated event,
    Emitter<AuthState> emit,
  ) async {
    emit(Authloading());
    try {
      final user = _authService.checkUserLogined();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("User is Not Aunthenticated"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
