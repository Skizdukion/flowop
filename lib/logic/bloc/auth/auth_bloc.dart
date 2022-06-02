import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowop/global/constant/error.dart';
import 'package:flowop/logic/repositories/auth_repository.dart';
import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flowop/global/error/auth_string_error.dart';
// import 'package:flowop/logic/providers/firebase_data.dart';
// import 'package:flowop/logic/repositories/auth_repository.dart';
// import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flowop/utils/string_extension.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AnonymousUser());
  final FireBaseAuthRepository _fireBaseAuthRepository =
      FireBaseAuthRepository();

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is Login) {
      yield const AuthLoading();
      String? checkLoginError = verifyLogin(event.email, event.password);
      if (checkLoginError != null) {
        yield VerifyFailed(errorString: checkLoginError);
      } else {
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: event.email, password: event.password);
          if (user.user != null) {
            UserRepository.uid = user.user!.uid;
            UserRepository.email = event.email;
            yield const LoggeddUser();
          }
        } on FirebaseAuthException catch (e) {
          yield VerifyFailed(errorString: e.code);
        } on Exception catch (e) {
          yield VerifyFailed(errorString: e.toString());
        }
      }
    }
    if (event is Logout) {
      _fireBaseAuthRepository.signOut();
      UserRepository.uid = null;
      UserRepository.email = null;
      yield const AnonymousUser();
    }
    if (event is Register) {
      yield const AuthLoading();
      String? checkLoginError = verifyLogin(event.email, event.password);
      if (checkLoginError != null) {
        yield VerifyFailed(errorString: checkLoginError);
      } else {
        try {
          UserCredential user = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: event.email, password: event.password);
          if (user.user != null) {
            UserRepository.uid = user.user!.uid;
            UserRepository.email = event.email;
            yield const LoggeddUser();
          }
        } on FirebaseAuthException catch (e) {
          yield VerifyFailed(errorString: e.code);
        } on Exception catch (e) {
          yield VerifyFailed(errorString: e.toString());
        }
      }
    }
  }
}
