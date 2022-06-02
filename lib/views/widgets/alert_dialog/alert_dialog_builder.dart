import 'package:flowop/global/constant/color.dart';
import 'package:flowop/global/constant/error.dart';
import 'package:flowop/global/constant/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flowop/utils/extension.dart';
import 'alert_dialog_widget.dart';

Future showDialogWidget(
    {required BuildContext context,
    required String errMsg,
    required DialogType dialogType,
    Function? onConfirm,
    bool? showCloseBtn}) async {
  String text = errMsg;
  if (SmartDialog.config.isExist) {
    SmartDialog.dismiss();
    await Future.delayed(const Duration(milliseconds: 10));
  }
  return SmartDialog.show(
      widget: Dialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2))),
    child: Container(
      constraints: const BoxConstraints(minHeight: 160),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(2)),
        child: onConfirm != null
            ? AlertDialogBuilder(context, text)
                .setType(dialogType, showCloseBtn: showCloseBtn)
                .setOnClickBtnConfirm(() {
                onConfirm.call();
              }).build()
            : AlertDialogBuilder(context, text).setType(dialogType).build(),
      ),
    ),
  ));
}

/// Build double dialog confirm
Future showDoubleDialogWidget(
    {required BuildContext context,
    required String msg,
    String? titleHeadBar,
    String? bodyTitle,
    DialogType dialogType = DialogType.doubleBtn,
    Function()? onClickBtn}) {
  return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(2)),
              child: AlertDialogBuilder(context, msg)
                  .setType(dialogType, showCloseBtn: false)
                  .setTitleHeadBar(titleHeadBar)
                  .setBodyTitle(bodyTitle)
                  .setOnClickBtnConfirm(() {
                if (onClickBtn != null) {
                  onClickBtn();
                }
              }).build(),
            ),
          ),
        );
      });
}

class AlertDialogBuilder {
  late DialogBar _headBar;
  late DialogIcon _icon;
  late DialogBody _body;
  DialogBtnConfirm? _btnConfirm;
  late DialogType _dialogType;
  late Color _btnColor;
  Text? _btnText;
  String? _title;
  String? _bodyTitle;
  Function? _onConfirm;
  late String _msg;
  late BuildContext _context;

  AlertDialogBuilder(BuildContext context, String msg) {
    _context = context;
    _msg = msg;
  }

  AlertDialogBuilder setType(DialogType dialogType, {bool? showCloseBtn}) {
    _dialogType = dialogType;
    switch (_dialogType) {
      case DialogType.error:
        _headBar = DialogBar(
          showCloseBtn: showCloseBtn ?? false,
        );
        _icon = const DialogIcon(asset: AppIcons.icError);
        _body = DialogBody(
          content: _msg,
        );
        break;
      case DialogType.warning:
        _headBar = DialogBar(
          showCloseBtn: showCloseBtn ?? false,
        );
        _icon = const DialogIcon(asset: AppIcons.icWarning);
        _body = DialogBody(
          content: _msg,
        );
        break;
      case DialogType.success:
        _headBar = DialogBar(
          showCloseBtn: showCloseBtn ?? false,
        );
        _icon = const DialogIcon(asset: AppIcons.icSuccess);
        _body = DialogBody(
          content: _msg,
        );
        break;
      case DialogType.singleBtn:
        _headBar = DialogBar(
          showCloseBtn: showCloseBtn ?? false,
        );
        _icon = const DialogIcon();
        _body = DialogBody(
          content: _msg,
        );
        break;
      case DialogType.doubleBtn:
        _headBar = DialogBar(
          showCloseBtn: showCloseBtn ?? false,
        );
        _icon = const DialogIcon();
        _body = DialogBody(
          content: _msg,
        );
        break;
      case DialogType.logout:
        _headBar = DialogBar(
          showCloseBtn: showCloseBtn ?? false,
        );
        _icon = const DialogIcon(
          iconWidget: SizedBox(),
        );
        _body = DialogBody(
          dialogBody: const SizedBox(),
        );
        break;
      case DialogType.report:
        // TODO: Handle this case.
        break;
    }
    return this;
  }

  AlertDialogBuilder setHeadBar(DialogBar dialogBar) {
    _headBar = dialogBar;
    return this;
  }

  AlertDialogBuilder setTitleHeadBar(String? titleHeadBar) {
    _title = titleHeadBar;
    _headBar.titleText = _title;
    return this;
  }

  AlertDialogBuilder setIcon(DialogIcon dialogIcon) {
    _icon = dialogIcon;
    return this;
  }

  AlertDialogBuilder setBody(DialogBody dialogBody) {
    _body = dialogBody;
    return this;
  }

  AlertDialogBuilder setBodyTitle(String? bodyTitle) {
    _bodyTitle = bodyTitle;
    _body.bodyTitle = _bodyTitle;
    return this;
  }

  AlertDialogBuilder setBtnConfirm(DialogBtnConfirm dialogBtnConfirm) {
    _btnConfirm = dialogBtnConfirm;
    return this;
  }

  AlertDialogBuilder setBtnText(Text? btnText) {
    _btnText = btnText;
    _btnConfirm?.btnTitle = _btnText;
    return this;
  }

  AlertDialogBuilder setBtnColor(Color color) {
    _btnColor = color;
    _btnConfirm?.btnColor = _btnColor;
    return this;
  }

  AlertDialogBuilder setOnClickBtnConfirm(Function? onTap) {
    _onConfirm = onTap;
    if (_btnConfirm == null) {
      _btnConfirm = DialogBtnConfirm(
        dialogType: _dialogType,
      );
    } else {
      _btnConfirm!.onConfirm = _onConfirm;
    }
    return this;
  }

  AlertDialogWidget build() {
    AlertDialogWidget alertDialogWidget = AlertDialogWidget(
      context: _context,
      dialogType: _dialogType,
      dialogBtnConfirm: _btnConfirm,
      dialogBody: _body,
      dialogIcon: _icon,
      dialogBar: _headBar,
      onConfirm: _onConfirm,
    );
    return alertDialogWidget;
  }
}

void showUnderDevelopmentFunction(BuildContext context) {
  showDialogWidget(
      context: context,
      errMsg: AppErrorString.functionUnderDevelopment,
      dialogType: DialogType.error);
}

void showLoadingDialog() {
  Widget dialog = Container(
    height: 100,
    width: 140,
    child: const CircularProgressIndicator(
      color: AppColors.primary,
    ).square(64).center(),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(color: Colors.black12, blurRadius: 1, spreadRadius: 1)
      ],
    ),
  );

  SmartDialog.show(
      widget: dialog,
      isLoadingTemp: false,
      clickBgDismissTemp: false,
      animationDurationTemp: const Duration(milliseconds: 200));
}

void closeLoading() {
  SmartDialog.dismiss();
}
