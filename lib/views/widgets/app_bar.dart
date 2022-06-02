import 'package:flowop/global/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flowop/utils/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class BaseAppBar extends StatelessWidget with PreferredSizeWidget {
  const BaseAppBar({
    Key? key,
    this.brightness = SystemUiOverlayStyle.light,
    this.title,
    this.canBack = true,
    this.centerTitle = true,
    this.actions,
    this.onBackPressed,
    this.backgroundColor,
    this.elevation,
    this.leading,
    this.appBarSize,
    this.actionButton,
    this.bottom,
  }) : super(key: key);

  final Widget? title;
  final bool canBack;
  final List<Widget>? actions;
  final bool centerTitle;
  final void Function()? onBackPressed;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? leading;
  final Size? appBarSize;
  final PreferredSize? bottom;
  final double kDefaultHeight = 44;
  final SystemUiOverlayStyle brightness;
  final Widget? actionButton;

  factory BaseAppBar.base(
      {String? title,
      bool showBackBtn = true,
      SystemUiOverlayStyle brightness = SystemUiOverlayStyle.light,
      Widget? customLeading,
      Widget? actionButton,
      Function()? onBackPress,
      Widget? customActionWidget}) {
    return BaseAppBar(
        appBarSize: const Size.fromHeight(44),
        title: (title ?? "App")
            .bold()
            .fSize(16)
            .color(brightness == SystemUiOverlayStyle.dark
                ? Colors.white
                : AppColors.textNeutral)
            .b(),
        backgroundColor: brightness == SystemUiOverlayStyle.light
            ? Colors.white
            : AppColors.textNeutral,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: AppColors.divider,
            height: 1,
          ),
        ),
        canBack: true,
        brightness: brightness,
        elevation: 0.0,
        onBackPressed: onBackPress,
        leading: customLeading,
        actionButton: actionButton,
        actions: customActionWidget != null ? [customActionWidget] : null);
  }

  factory BaseAppBar.lightAppBar(
      {required BuildContext context,
      double? height,
      required String titleString,
      bool? showBack}) {
    return BaseAppBar(
      canBack: showBack ?? true,
      backgroundColor: Colors.white,
      appBarSize: Size(MediaQuery.of(context).size.width, height ?? 44),
      centerTitle: true,
      elevation: 0,
      title: titleString.appBarTitle(),
      leading: (showBack ?? true)
          ? const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ).center().square(24).inkTap(onTap: () {
              Get.back();
            })
          : null,
      bottom: PreferredSize(
          child: Container(
            color: Colors.black.withOpacity(0.08),
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(1)),
    );
  }

  factory BaseAppBar.mainBar(
      {required BuildContext context,
      double? height,
      required Function() logout}) {
    return BaseAppBar(
      backgroundColor: Colors.white,
      appBarSize: Size(MediaQuery.of(context).size.width, height ?? 44),
      centerTitle: true,
      canBack: false,
      elevation: 0,
      title: 'Patient Management'.appBarTitle(),
      // actionButton: const,
      actions: [
        const Icon(Icons.logout, size: 40, color: Colors.black)
            .marg(0, 10)
            .inkTap(onTap: () => logout.call())
      ],
      bottom: PreferredSize(
          child: Container(
            color: Colors.black.withOpacity(0.08),
            height: 1.0,
          ),
          preferredSize: const Size.fromHeight(1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      bottom: bottom,
      title: title,
      centerTitle: centerTitle,
      actions: actions ??
          (actionButton != null ? [actionButton!.pad(0, 10, 0)] : []),
      backgroundColor: backgroundColor,
      elevation: elevation,
      leading: () {
        if (leading != null) {
          return leading;
        } else {
          if (canBack) {
            return IconButton(
              onPressed: () {
                if (onBackPressed != null) {
                  onBackPressed?.call();
                  return;
                }
                Navigator.of(context).pop();
              },
              color: brightness == SystemUiOverlayStyle.light
                  ? AppColors.textNeutral
                  : Colors.white,
              icon: const Icon(Icons.arrow_back_ios, size: 20.0),
            );
          } else {
            return null;
          }
        }
      }(),
    );
  }

  @override
  Size get preferredSize =>
      appBarSize ??
      Size(AppBar().preferredSize.width, AppBar().preferredSize.height);
}
