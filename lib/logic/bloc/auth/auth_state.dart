import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AnonymousUser extends AuthState {
  const AnonymousUser();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class LoggeddUser extends AuthState {
  const LoggeddUser();
}

class VerifyFailed extends AuthState {
  const VerifyFailed({required this.errorString});

  final String errorString;

  @override
  List<Object?> get props => [errorString];
}