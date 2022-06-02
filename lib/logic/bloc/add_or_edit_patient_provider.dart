import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowop/logic/models/patient.dart';
import 'package:flowop/logic/repositories/user_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

class AddPatientProvider with ChangeNotifier {
  Gender? _gender;
  Gender? get gender => _gender;
  PatientModel? patientModel;
  set gender(Gender? value) {
    _gender = value;
    notifyListeners();
  }

  late final TextEditingController ageController;
  late final TextEditingController avgGlucoseController;
  late final TextEditingController bmiController;
  late final TextEditingController nameController;

  bool _hypertension = false;
  bool get hypertension => _hypertension;
  set hypertension(bool value) {
    _hypertension = value;
    notifyListeners();
  }

  bool _heartDisease = false;
  bool get heartDisease => _heartDisease;
  set heartDisease(bool value) {
    _heartDisease = value;
    notifyListeners();
  }

  bool _everMarried = false;
  bool get everMarried => _everMarried;
  set everMarried(bool value) {
    _everMarried = value;
    notifyListeners();
  }

  WorkType? _workType;
  WorkType? get workType => _workType;
  set workType(WorkType? value) {
    _workType = value;
    notifyListeners();
  }

  ResidenceType? _residenceType;
  ResidenceType? get residenceType => _residenceType;
  set residenceType(ResidenceType? value) {
    _residenceType = value;
    notifyListeners();
  }

  SmokingStatus? _smokingStatus;
  AddPatientProvider({this.patientModel}) {
    nameController = TextEditingController();
    ageController = TextEditingController();
    avgGlucoseController = TextEditingController();
    bmiController = TextEditingController();
    nameController.text = patientModel?.name.toString() ?? '';
    ageController.text = patientModel?.age.toString() ?? '0';
    avgGlucoseController.text = patientModel?.avgGlucoseLevel.toString() ?? '0';
    bmiController.text = patientModel?.bmi.toString() ?? '0';
    _gender = patientModel?.gender;
    _smokingStatus = patientModel?.smokingStatus;
    _workType = patientModel?.workType;
    _residenceType = patientModel?.residenceType;
    _hypertension = patientModel?.hypertension ?? false;
    _heartDisease = patientModel?.heartDisease ?? false;
    _everMarried = patientModel?.everMarried ?? false;
  }
  SmokingStatus? get smokingStatus => _smokingStatus;
  set smokingStatus(SmokingStatus? value) {
    _smokingStatus = value;
    notifyListeners();
  }

  Future<String?> submit() {
    if (double.parse(ageController.text) == 0) {
      return Future.value("Patient's age is invalid");
    }
    if (double.parse(avgGlucoseController.text) == 0) {
      return Future.value("Patient's avg glucose is invalid");
    }
    if (double.parse(bmiController.text) == 0) {
      return Future.value("Patient's Bmi is invalid");
    }
    if (gender == null) {
      return Future.value("Please choose Patient's gender");
    }
    if (nameController.text.isEmpty) {
      return Future.value("Please provide patient's name");
    }
    if (smokingStatus == null) {
      return Future.value("Please choose Patient's smoking status");
    }
    if (workType == null) {
      return Future.value("Please choose Patient's work type");
    }
    if (residenceType == null) {
      return Future.value("Please choose Patient's residence type");
    }
    patientModel = PatientModel(
        id: patientModel == null ? getRandomString(5) : patientModel!.id,
        gender: gender!,
        name: nameController.text,
        age: double.parse(ageController.text),
        hypertension: hypertension,
        heartDisease: heartDisease,
        everMarried: everMarried,
        workType: workType!,
        residenceType: residenceType!,
        avgGlucoseLevel: double.parse(avgGlucoseController.text),
        bmi: double.parse(bmiController.text),
        smokingStatus: smokingStatus!);

    FirebaseFirestore.instance
        .collection('user_data')
        .doc(UserRepository.uid)
        .collection('patient')
        .doc(patientModel!.id)
        .set(patientModel!.toJson());
    return Future.value(null);
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
