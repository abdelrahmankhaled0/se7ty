abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSucessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState({required this.error});
}
