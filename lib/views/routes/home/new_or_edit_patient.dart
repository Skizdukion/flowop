import 'dart:io';

import 'package:flowop/logic/bloc/add_or_edit_patient_provider.dart';
import 'package:flowop/logic/models/patient.dart';
import 'package:flowop/utils/snack_bar.dart';
import 'package:flowop/views/widgets/app_bar.dart';
import 'package:flowop/views/widgets/custom_textfield/configs/decoration_config.dart';
import 'package:flowop/views/widgets/custom_textfield/configs/textfield_config.dart';
import 'package:flowop/views/widgets/custom_textfield/shadow_textfield.dart';
import 'package:flowop/views/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:flowop/utils/extension.dart';

class AddOrEditPatient extends StatefulWidget {
  const AddOrEditPatient({Key? key, this.patient}) : super(key: key);
  final PatientModel? patient;

  @override
  _AddOrEditPatientState createState() => _AddOrEditPatientState();
}

class _AddOrEditPatientState extends State<AddOrEditPatient> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar.lightAppBar(
          context: context,
          titleString:
              "${(widget.patient == null) ? 'Add New' : 'Edit'} Patient"),
      body: ChangeNotifierProvider<AddPatientProvider>(
        create: (_) => AddPatientProvider(patientModel: widget.patient),
        child: Consumer<AddPatientProvider>(
          builder: (context, providerVal, child) {
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Patient Name:'.desc().marg(0, 0, 20),
                      AppTextInputField.authVisibleInputText(
                        controller: providerVal.nameController,
                      ).marg(0, 0, 6, 20),
                      _buildNumberInput(providerVal),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDropDown(providerVal),
                          const SizedBox(width: 20),
                          _buildCheckBox(providerVal),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                providerVal.submit().then((value) {
                                  if (value == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        ExpandedSnackBar.successSnackBar(
                                            context,
                                            (widget.patient == null)
                                                ? "Add new patient success"
                                                : "Saved success"));
                                    Get.back(result: providerVal.patientModel);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        ExpandedSnackBar.failureSnackBar(
                                            context, value));
                                  }
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 12),
                                child: Text(
                                  ((widget.patient == null)
                                      ? "Submit"
                                      : "Save"),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ).unfocus();
  }

  Expanded _buildCheckBox(AddPatientProvider providerVal) {
    return Expanded(
      child: Column(
        children: [
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                "Hypertension",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: providerVal.hypertension,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                providerVal.hypertension = value ?? false;
              }),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                "Heart disease",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: providerVal.heartDisease,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                providerVal.heartDisease = value ?? false;
              }),
          CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: const Text(
                "Ever married",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: providerVal.everMarried,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (value) {
                providerVal.everMarried = value ?? false;
              }),
        ],
      ),
    );
  }

  Container _buildDropDown(AddPatientProvider providerVal) {
    return Container(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 2,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 0.0,
                horizontal: 10.0,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Gender>(
                  isExpanded: true,
                  hint: const Text("Gender",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey)),
                  items: Gender.values
                      .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.value(),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )))
                      .toList(),
                  value: providerVal.gender,
                  onChanged: (value) {
                    providerVal.gender = value;
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 160,
            child: Material(
              color: Colors.transparent,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<SmokingStatus>(
                    isExpanded: true,
                    hint: const Text("Smoking",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    items: SmokingStatus.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        .toList(),
                    value: providerVal.smokingStatus,
                    onChanged: (value) {
                      providerVal.smokingStatus = value;
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 160,
            child: Material(
              color: Colors.transparent,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<WorkType>(
                    isExpanded: true,
                    hint: const Text("Work Type",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    items: WorkType.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        .toList(),
                    value: providerVal.workType,
                    onChanged: (value) {
                      providerVal.workType = value;
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            width: 160,
            child: Material(
              color: Colors.transparent,
              elevation: 2,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 10.0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<ResidenceType>(
                    isExpanded: true,
                    hint: const Text("Residence",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                    items: ResidenceType.values
                        .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.value(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            )))
                        .toList(),
                    value: providerVal.residenceType,
                    onChanged: (value) {
                      providerVal.residenceType = value;
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Row _buildNumberInput(AddPatientProvider providerVal) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 100,
          child: ShadowTextField(
            textFieldConfig: TextFieldConfig(
                controller: providerVal.ageController,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onChanged: (value) {
              if (value.isEmpty) {
                providerVal.ageController.text = '0';
                providerVal.ageController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.ageController.text.length));
              } else if (value.length > 1 &&
                  value[0] == '0' &&
                  !value.contains('.')) {
                providerVal.ageController.text = value.substring(1);
                providerVal.ageController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.ageController.text.length));
              }
            },
            decorationConfig: const TextFieldDecorationConfig(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                labelText: "Age",
                labelStyle: TextStyle(fontSize: 14)),
            textFieldType: TextFieldType.number,
            validator: TextFieldValidatorUtils.validateText,
          ),
        ),
        SizedBox(
          width: 120,
          child: ShadowTextField(
            textFieldConfig: TextFieldConfig(
                controller: providerVal.avgGlucoseController,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onChanged: (value) {
              if (value.isEmpty) {
                providerVal.avgGlucoseController.text = '0';
                providerVal.avgGlucoseController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.avgGlucoseController.text.length));
              } else if (value.length > 1 &&
                  value[0] == '0' &&
                  !value.contains('.')) {
                providerVal.avgGlucoseController.text = value.substring(1);
                providerVal.avgGlucoseController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.avgGlucoseController.text.length));
              }
            },
            decorationConfig: const TextFieldDecorationConfig(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                labelText: "Avg glucose",
                labelStyle: TextStyle(fontSize: 14)),
            textFieldType: TextFieldType.number,
            validator: TextFieldValidatorUtils.validateText,
          ),
        ),
        SizedBox(
          width: 100,
          child: ShadowTextField(
            textFieldConfig: TextFieldConfig(
                controller: providerVal.bmiController,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            onChanged: (value) {
              if (value.isEmpty) {
                providerVal.bmiController.text = '0';
                providerVal.bmiController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.bmiController.text.length));
              } else if (value.length > 1 &&
                  value[0] == '0' &&
                  !value.contains('.')) {
                providerVal.bmiController.text = value.substring(1);
                providerVal.bmiController.selection =
                    TextSelection.fromPosition(TextPosition(
                        offset: providerVal.bmiController.text.length));
              }
            },
            decorationConfig: const TextFieldDecorationConfig(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 14.0,
                  horizontal: 12.0,
                ),
                labelText: "Bmi",
                labelStyle: TextStyle(fontSize: 14)),
            textFieldType: TextFieldType.number,
            validator: TextFieldValidatorUtils.validateText,
          ),
        ),
      ],
    );
  }
}
