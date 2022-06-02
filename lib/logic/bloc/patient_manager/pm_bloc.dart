import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flowop/global/constant/error.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_event.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_state.dart';
import 'package:flowop/logic/repositories/auth_repository.dart';
import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flowop/global/error/auth_string_error.dart';
// import 'package:flowop/logic/providers/firebase_data.dart';
// import 'package:flowop/logic/repositories/auth_repository.dart';
// import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flowop/utils/string_extension.dart';

class PMBloc extends Bloc<PMEvent, PMState> {
  PMBloc() : super(const NotConnectedServer());

  @override
  Stream<PMState> mapEventToState(PMEvent event) async* {
    if (event is ConnectServer) {
      yield ConnectedServer(event.socket);
    }
  }
}
