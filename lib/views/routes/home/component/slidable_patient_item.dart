import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

// import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_bloc.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_event.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_state.dart';
import 'package:flowop/logic/models/patient.dart';
import 'package:flowop/logic/repositories/patient_repositories.dart';
import 'package:flowop/utils/snack_bar.dart';
import 'package:flowop/views/routes/home/patient_details.dart';
import 'package:flowop/views/routes/home/server_connector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flowop/utils/extension.dart';

import '../new_or_edit_patient.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class PatientItem extends StatefulWidget {
  const PatientItem({Key? key, required this.patient}) : super(key: key);
  final PatientModel patient;

  @override
  _PatientItemState createState() => _PatientItemState();
}

class _PatientItemState extends State<PatientItem> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      showAllActionsThreshold: 0.1,
      actionExtentRatio: 0.25,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        color: Colors.white,
        elevation: 3.0,
        child: ListTile(
          leading: IconButton(
            icon: Icon(
                (widget.patient.gender == Gender.male)
                    ? Icons.male
                    : Icons.female,
                color: (widget.patient.strokePredict ?? false)
                    ? const Color.fromRGBO(249, 96, 96, 1)
                    : const Color.fromRGBO(96, 116, 249, 1)),
            onPressed: _showPatientDetail,
          ),
          title:
              (widget.patient.name).secondaryTitle().align(Alignment.topLeft),
          subtitle: ("Age: " +
                  widget.patient.age.toString() +
                  ", BMI: " +
                  widget.patient.bmi.toString())
              .desc(),
          shape: Border(
            right: BorderSide(
                width: 10.0,
                color: (widget.patient.strokePredict ?? false)
                    ? const Color.fromRGBO(249, 96, 96, 1)
                    : const Color.fromRGBO(96, 116, 249, 1),
                style: BorderStyle.solid),
          ),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          color: Colors.white10,
          iconWidget: const Icon(Icons.edit_outlined,
              color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => AddOrEditPatient(
                        patient: widget.patient,
                      )),
            );
          },
        ),
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: const Icon(Icons.delete_outline,
                color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: deletePatient,
          ),
          decoration: const BoxDecoration(
            color: Colors.white10,
            border: Border(
              left: BorderSide(
                  width: 0.5, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
      ],
      secondaryActions: <Widget>[
        Container(
          child: IconSlideAction(
            color: Colors.white10,
            iconWidget: const Icon(Icons.edit_outlined,
                color: Color.fromRGBO(249, 96, 96, 1)),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => AddOrEditPatient(
                          patient: widget.patient,
                        )),
              );
            },
          ),
          decoration: const BoxDecoration(
            color: Colors.white10,
            border: Border(
              right: BorderSide(
                  width: 0.5, color: Colors.black, style: BorderStyle.solid),
            ),
          ),
        ),
        IconSlideAction(
          color: Colors.white10,
          iconWidget: const Icon(Icons.delete_outline,
              color: Color.fromRGBO(249, 96, 96, 1)),
          onTap: deletePatient,
        ),
      ],
    ).inkTap(onTap: _showPatientDetail);
  }

  void deletePatient() async {
    var result = await showOkCancelAlertDialog(
        context: context, title: 'Are you wish to delete this patient?');
    if (result == OkCancelResult.ok) {
      FirebasePatientRepository.deletePatient(widget.patient.id);
    }
  }

  void showReceivedNewData(String id) {
    ScaffoldMessenger.of(context).showSnackBar(ExpandedSnackBar.successSnackBar(
        context, "Stroke Prediction status updated"));
  }

  void showSendSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(ExpandedSnackBar.successSnackBar(
        context, "Send patient data successfully"));
  }

  void _showPatientDetail() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => PatitentDetailsPage(
                patient: widget.patient,
                strokePredict: () async {
                  if (FirebasePatientRepository.serversocket != null) {
                    FirebasePatientRepository.serversocket!
                        .write('send:${widget.patient.toString()}');
                    showSendSuccess();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        ExpandedSnackBar.failureSnackBar(
                            context, "Please connect to a publish server"));
                    var isSuccess = await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const ServerConnector()),
                    );
                    if (isSuccess ?? false) {
                      // print(FirebasePatientRepository.serversocket!);
                      FirebasePatientRepository.serversocket!
                          .write('send:${widget.patient.toString()}');
                      showSendSuccess();
                      FirebasePatientRepository.serversocket!.listen(
                        (Uint8List data) {
                          final String serverResponse =
                              String.fromCharCodes(data);
                          if (serverResponse.contains('prediction:')) {
                            String id = serverResponse
                                .replaceAll('prediction:', '')
                                .split(';')[0]
                                .split(',')[0];
                            String predict = serverResponse
                                .replaceAll('prediction:', '')
                                .split(';')[0]
                                .split(',')[1];
                            FirebasePatientRepository.changePredictionState(
                                id, double.parse(predict) == 1 ? true : false);
                            showReceivedNewData(id);
                          }
                        },
                      );
                    }
                  }
                },
              )),
    );
  }
}
