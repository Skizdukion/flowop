import 'package:flowop/global/decoration/text_decor.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_bloc.dart';
import 'package:flowop/logic/bloc/patient_manager/pm_state.dart';
import 'package:flowop/logic/models/patient.dart';
import 'package:flowop/views/widgets/app_bar.dart';
import 'package:flowop/views/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowop/utils/extension.dart';

class PatitentDetailsPage extends StatefulWidget {
  const PatitentDetailsPage(
      {Key? key, required this.patient, required this.strokePredict})
      : super(key: key);
  final PatientModel patient;
  final void Function() strokePredict;

  @override
  State<PatitentDetailsPage> createState() => _PatitentDetailsPageState();
}

class _PatitentDetailsPageState extends State<PatitentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<PMBloc, PMState>(builder: (context, state) {
    //   return SafeArea(
    //     child: Scaffold(
    //       appBar: BaseAppBar.lightAppBar(
    //         titleString: "Patient Details",
    //         context: context,
    //       ),
    //       body: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             widget.patient.name,
    //             style: AppTextDecoration.darkS18
    //                 .copyWith(fontWeight: FontWeight.bold),
    //           ).center().marg(0, 0, 10, 0),
    //           const SizedBox(
    //             height: 20,
    //           ),
    //           Row(
    //             children: [
    //               ("Age: " + widget.patient.age.toString()).desc().expand(),
    //               ("Gender: " + widget.patient.gender.toString())
    //                   .desc()
    //                   .expand(),
    //             ],
    //           ).marg(0, 0, 10, 0),
    //           Row(
    //             children: [
    //               ("Hypertension: " + widget.patient.hypertension.toString())
    //                   .desc()
    //                   .expand(),
    //               ("Heart Disease: " + widget.patient.heartDisease.toString())
    //                   .desc()
    //                   .expand(),
    //             ],
    //           ).marg(0, 0, 10, 0),
    //           Row(
    //             children: [
    //               ("Ever married: " + widget.patient.everMarried.toString())
    //                   .desc()
    //                   .expand(),
    //               ("Work Type: " + widget.patient.workType.toString())
    //                   .desc()
    //                   .expand(),
    //             ],
    //           ).marg(0, 0, 10, 0),
    //           Row(
    //             children: [
    //               ("Resiendence Type: " +
    //                       widget.patient.residenceType.toString())
    //                   .desc()
    //                   .expand(),
    //               ("Avg Glucose Level: " +
    //                       widget.patient.avgGlucoseLevel.toString())
    //                   .desc()
    //                   .expand(),
    //             ],
    //           ).marg(0, 0, 10, 0),
    //           Row(
    //             children: [
    //               ("BMI: " + widget.patient.bmi.toString()).desc().expand(),
    //               ("Smoking status: " + widget.patient.smokingStatus.toString())
    //                   .desc()
    //                   .expand(),
    //             ],
    //           ).marg(0, 0, 10, 0),
    //         ],
    //       ),
    //     ),
    //   );
    // });
    return SafeArea(
      child: Scaffold(
        appBar: BaseAppBar.lightAppBar(
          titleString: "Patient Details",
          context: context,
          showBack: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.patient.name,
              style: AppTextDecoration.darkS18
                  .copyWith(fontWeight: FontWeight.bold),
            ).center().marg(0, 0, 10, 0),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                ("Age: " + widget.patient.age.toString()).desc().expand(),
                ("Gender: " + widget.patient.gender.value()).desc().expand(),
              ],
            ).marg(0, 0, 20, 0),
            Row(
              children: [
                ("Hypertension: " + widget.patient.hypertension.toString())
                    .desc()
                    .expand(),
                ("Heart Disease: " + widget.patient.heartDisease.toString())
                    .desc()
                    .expand(),
              ],
            ).marg(0, 0, 20, 0),
            Row(
              children: [
                ("Ever married: " + widget.patient.everMarried.toString())
                    .desc()
                    .expand(),
                ("Work Type: " + widget.patient.workType.value())
                    .desc()
                    .expand(),
              ],
            ).marg(0, 0, 20, 0),
            Row(
              children: [
                ("Resiendence Type: " + widget.patient.residenceType.value())
                    .desc()
                    .expand(),
                ("Avg Glucose Level: " +
                        widget.patient.avgGlucoseLevel.toString())
                    .desc()
                    .expand(),
              ],
            ).marg(0, 0, 20, 0),
            Row(
              children: [
                ("BMI: " + widget.patient.bmi.toString()).desc().expand(),
                ("Smoking status: " + widget.patient.smokingStatus.value())
                    .desc()
                    .expand(),
              ],
            ).marg(0, 0, 20, 0),
            ('Stroke Prediction: ' +
                    (widget.patient.strokePredict?.toString() ??
                        'Unaccomplished'))
                .desc()
                .marg(0, 0, 20, 0),
            const Spacer(),
            AppButton.primary(
              onTap: () {
                Navigator.pop(context);
                widget.strokePredict.call();
              },
              child: 'Stroke Predict'.buttonTitle(),
              borderRadius: BorderRadius.circular(2),
            ).marg(0, 0, 0, 40),
          ],
        ).marg(0, 10),
      ),
    );
  }
}
