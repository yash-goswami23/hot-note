part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthSignIn({required this.email, required this.password});
}

// final class CheckIsAuthenticated extends AuthEvent {}
final class Logout extends AuthEvent {}
