import 'package:equatable/equatable.dart';
import 'package:flowop/global/constant/error.dart';
import 'package:flowop/utils/string_extension.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;
}

class Login extends AuthEvent {
  const Login({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class Register extends AuthEvent {
  const Register({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class Loading extends AuthEvent {
  const Loading();
}

class Logout extends AuthEvent {
  const Logout();
}


String? verifyLogin(String email, String password) {
  if (email.isEmpty) {
    return AppErrorString.emptyEmailAddress;
  }

  if (!email.isValidEmail()) {
    return AppErrorString.unvalidEmailAddress;
  }

  if (password.isEmpty) {
    return AppErrorString.emptyPassword;
  }

  if (password.length < 6) {
    return AppErrorString.notEnoughPasswordLength;
  }
}
