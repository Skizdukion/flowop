import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowop/logic/models/patient.dart';
import 'package:flowop/logic/repositories/user_repository.dart';

class FirebasePatientRepository {

  static Socket? serversocket;

  static Stream<List<PatientModel>> getAllPatientStreamFromCurrentLoggedUser() {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(UserRepository.uid)
        .collection('patient')
        .snapshots()
        .map(_patientListFromSnpShot);
  }

  static List<PatientModel> _patientListFromSnpShot(QuerySnapshot snpshot) {
    return snpshot.docs.map((doc) {
      return PatientModel.fromSnp(doc);
    }).toList();
  }

  static changePredictionState(String patientId, bool newState) {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(UserRepository.uid)
        .collection('patient')
        .doc(patientId)
        .update({'strokePredict': newState});
  }

  static deletePatient(String patientId) {
    return FirebaseFirestore.instance
        .collection('user_data')
        .doc(UserRepository.uid)
        .collection('patient')
        .doc(patientId)
        .delete();
  }
}
