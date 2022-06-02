// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

// ignore: implementation_imports
import 'package:flowop/global/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flowop/utils/extension.dart';

enum DialogType {
  error,
  warning,
  success,
  singleBtn,
  doubleBtn,
  report,
  logout
}

class AlertDialogWidget extends StatefulWidget {
  final Widget dialogBar;
  final Widget dialogIcon;
  final Widget dialogBody;
  final Widget? dialogBtnConfirm;
  final DialogType dialogType;
  final BuildContext context;
  final Function? onConfirm;

  const AlertDialogWidget({
    required this.dialogBar,
    required this.dialogBody,
    required this.dialogBtnConfirm,
    required this.dialogIcon,
    required this.dialogType,
    required this.context,
    this.onConfirm,
  });

  @override
  _AlertDialogWidgetState createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            widget.dialogBar,
            widget.dialogIcon,
          ],
        ).pad(0, 0, 0, 0),
        widget.dialogBody,
        widget.dialogBtnConfirm ??
            Container(
              height: 20,
            ),
      ],
    );
  }
}

class DialogBar extends StatelessWidget {
  final Widget? titleWidget;
  final Widget? closeBtnWidget;
  final bool showCloseBtn;
  String? titleText;

  DialogBar(
      {this.closeBtnWidget,
      this.titleWidget,
      this.showCloseBtn = false,
      this.titleText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          titleWidget == null
              ? Container(
                  height: 24,
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        //width: 200,
                        child: (titleText ?? '').bold().fSize(16).b()),
                  ],
                ),
          showCloseBtn
              ? closeBtnWidget != null
                  ? closeBtnWidget!
                  : Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                              onTap: () {
                                SmartDialog.dismiss();
                              },
                              child: const Icon(
                                Icons.close,
                                size: 16,
                              color: AppColors.redLike,
                              ).pad(4).rectAll(10,
                                  color:
                                      const Color.fromRGBO(253, 224, 224, 1.0)))
                          .pad(0, 8, 0),
                    )
              : Container(
                  height: 0,
                )
        ],
      ),
    );
  }
}

class DialogBody extends StatelessWidget {
  final Widget? dialogBody;
  final double? width;
  final double? height;
  final String? content;
  String? bodyTitle;

  DialogBody(
      {this.dialogBody, this.width, this.height, this.content, this.bodyTitle});

  @override
  Widget build(BuildContext context) {
    double _width = width != null ? width! : 420;
    double _height = height != null ? height! : 400;

    if (dialogBody != null) {
      return dialogBody!;
    } else {
      return content != null
          ? Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  bodyTitle != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: bodyTitle!.plain().fSize(16).b(),
                        )
                      : const SizedBox(
                          width: 0,
                          height: 0,
                        ),
                  Container(
                      constraints:
                          BoxConstraints(maxHeight: _height, maxWidth: _width),
                      child: SingleChildScrollView(
                              child: '$content'.plain().fSize(16).b())
                          .pad(0, 0, 0, 20)),
                ],
              ),
            )
          : const SizedBox(
              width: 0,
              height: 0,
            );
    }
  }
}

class DialogIcon extends StatelessWidget {
  final Widget? iconWidget;
  final String? asset;

  const DialogIcon({this.iconWidget, this.asset});

  @override
  Widget build(BuildContext context) {
    return iconWidget != null
        ? iconWidget!
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              asset != null
                  ? SvgPicture.asset(asset!)
                  : const SizedBox(
                      width: 0,
                      height: 0,
                    ),
            ],
          );
  }
}

class DialogBtnConfirm extends StatelessWidget {
  final Widget? confirmBtnWidget;
  final DialogType? dialogType;
  Text? btnTitle;
  Color? btnColor;
  Function? onConfirm;
  final BorderRadius btnRadius = const BorderRadius.all(Radius.circular(2));

  DialogBtnConfirm(
      {this.confirmBtnWidget,
      @required this.dialogType,
      this.btnTitle,
      this.btnColor,
      this.onConfirm});

  @override
  Widget build(BuildContext context) {
    if (dialogType == DialogType.singleBtn) {
      return confirmBtnWidget != null && onConfirm != null
          ? confirmBtnWidget!
          : Column(
              children: [
                buildConfirmDefaultBtn(context),
              ],
            ).marg(16, 16, 0, 16);
    } else if (dialogType == DialogType.doubleBtn ||
        dialogType == DialogType.logout) {
      return confirmBtnWidget != null && onConfirm != null
          ? Column(
              children: [
                confirmBtnWidget!,
                const SizedBox(height: 12),
                buildCancelDefaultBtn(context),
              ],
            ).marg(16, 16, 0, 16)
          : Column(
              children: [
                buildConfirmDefaultBtn(context),
                const SizedBox(height: 12),
                buildCancelDefaultBtn(context),
              ],
            ).marg(16, 16, 0, 16);
    } else {
      return buildDialogTypeDefaultBtn(context: context).marg(16, 16, 0, 16);
    }
  }

  Widget buildCancelDefaultBtn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: btnRadius,
        color: Colors.white,
        border: Border.all(color: AppColors.border),
      ),
      child: 'Cancel'
          .secondaryDescColor(color: AppColors.grayButton)
          .center()
          .marg(10, 0),
    ).inkTap(
      onTap: () => Navigator.pop(context),
      borderRadius: BorderRadius.circular(2),
    );
  }

  Widget buildConfirmDefaultBtn(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: btnRadius,
        color: btnColor ?? AppColors.primaryBase,
      ),
//        constraints: BoxConstraints(
//          maxWidth: 250,
//        ),
//        decoration: BoxDecoration(
//            color: btnColor != null ? btnColor : colors.primary,
//            borderRadius: BorderRadius.all(
//              Radius.circular(10),
//            )),
      child: Center(
        child: btnTitle ??
            'Confirm'
                .secondaryDescColor(color: Colors.white)
                .center()
                .marg(10, 0),
      ),
    ).inkTap(
      onTap: onConfirm != null
          ? () {
              onConfirm!.call();
            }
          : () {
              Navigator.of(context).pop();
            },
      borderRadius: btnRadius,
    );
  }

  Widget buildSingleDefaultBtn(
    BuildContext context,
  ) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: btnRadius,
        color: btnColor ?? AppColors.primaryBase,
      ),
      child: Center(
        child: btnTitle ??
            'OK'.secondaryDescColor(color: Colors.white).center().marg(10, 0),
      ),
    ).inkTap(
      onTap: onConfirm != null
          ? () {
              onConfirm!.call();
            }
          : () {
              Navigator.of(context).pop();
            },
      borderRadius: btnRadius,
    );
  }

  Widget buildDialogTypeDefaultBtn({required BuildContext context}) {
    return Material(
      color: dialogType == DialogType.error
          ? const Color(0xffffd3d3)
          : dialogType == DialogType.warning
              ? const Color(0xfffff7e5)
              : AppColors.secondary,
      borderRadius: btnRadius,
      child: InkWell(
        onTap: onConfirm != null
            ? () {
                onConfirm!.call();
              }
            : () {
                Navigator.of(context).pop();
              },
        highlightColor: Colors.black54,
        child: Container(
          height: 50,
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
          ),
          child: Center(
            child: 'confirm'
                .secondaryDescColor(color: Colors.white)
                .center()
                .marg(10, 0),
          ),
        ),
      ),
    ).pad(10);
  }

  Widget buildButton({
    required String title,
    TextStyle? style,
    Function()? onClickBtn,
    double? width,
    double? height,
    required BuildContext context,
    Decoration? decoration,
  }) {
    return GestureDetector(
      onTap: onClickBtn != null
          ? onClickBtn()
          : () {
              Navigator.of(context).pop();
            },
      child: Container(
        height: height ?? 40,
        constraints: BoxConstraints(
          maxWidth: width ?? double.infinity,
        ),
        decoration: decoration ??
            const BoxDecoration(
              color: AppColors.primary,
            ),
        child: Center(
          child: title.bold().fSize(16).b(),
        ),
      ),
    );
  }
}
