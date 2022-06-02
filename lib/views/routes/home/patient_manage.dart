import 'dart:typed_data';

import 'package:flowop/logic/bloc/auth/auth_bloc.dart';
import 'package:flowop/logic/bloc/auth/auth_event.dart';
import 'package:flowop/logic/bloc/auth/auth_state.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_bloc.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_state.dart';
import 'package:flowop/logic/models/patient.dart';
import 'package:flowop/logic/repositories/patient_repositories.dart';
import 'package:flowop/views/routes/auth/login_page.dart';
import 'package:flowop/views/routes/home/component/slidable_patient_item.dart';
import 'package:flowop/views/routes/home/new_or_edit_patient.dart';
import 'package:flowop/views/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flowop/utils/extension.dart';

class PatientsManager extends StatefulWidget {
  const PatientsManager({Key? key}) : super(key: key);

  @override
  State<PatientsManager> createState() => _PatientsManagerState();
}

class _PatientsManagerState extends State<PatientsManager> {
  BehaviorSubject<List<PatientModel>> patients = BehaviorSubject();

  @override
  void initState() {
    patients.addStream(
        FirebasePatientRepository.getAllPatientStreamFromCurrentLoggedUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (_) => PMBloc(),
    //   child: BlocListener<PMBloc, PMState>(
    //       listener: (context, state) {
    //         if (state is ConnectedServer) {
    //           state.socket.listen(
    //             (Uint8List data) {
    //               final String serverResponse = String.fromCharCodes(data);
    //               if (serverResponse.contains('prediction:')) {
    //                 String id = serverResponse
    //                     .replaceAll('prediction:', '')
    //                     .split(';')[0]
    //                     .split(',')[0];
    //                 String predict = serverResponse
    //                     .replaceAll('prediction:', '')
    //                     .split(';')[0]
    //                     .split(',')[1];
    //                 // var list = patients.value;
    //                 FirebasePatientRepository.changePredictionState(
    //                     id, double.parse(predict) == 1 ? true : false);
    //               }
    //             },
    //           );
    //         }
    //       },
    //       child: ),
    // );
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        appBar: BaseAppBar.mainBar(
          context: context,
          logout: () {
            context.read<AuthBloc>().add(const Logout());
            Get.to(() => const LoginPage());
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddOrEditPatient()),
            );
          },
          tooltip: 'Add',
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<List<PatientModel>>(
          stream: patients,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const SpinKitChasingDots(
                color: Colors.blue,
              ).center();
            }
            // if (snapshot.)
            if (patients.value.isEmpty) {
              return "You dont have any patient yet, please create one by add-button at bottom-right on the screen"
                  .desc()
                  .rectangle(300, 100)
                  .center();
            } else {
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return PatientItem(patient: patients.value[index]);
                },
                itemCount: patients.value.length,
              );
            }
          },
        ),
      ));
    });
  }
}
