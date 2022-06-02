import 'package:flowop/global/constant/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final double? elevation;
  final Color? backgroundColor;
  final Widget? child;
  final Function? onTap;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final double? height;
  final Brightness? brightness;
  final BorderRadius? borderRadius;
  final bool horizontalExpand;
  final bool disableButton;

  AppButton._(
      {this.elevation,
      this.backgroundColor,
      this.child,
      this.onTap,
      this.shape,
      this.side,
      this.textStyle,
      this.padding,
      this.borderRadius,
      this.height,
      this.brightness,
      this.horizontalExpand = false,
      this.disableButton = false});

  factory AppButton.horizontalStretch({
    required Function onTap,
    Widget? child,
    Color? backgroundColor,
    TextStyle? textStyle,
    OutlinedBorder? shape,
    BorderRadius? borderRadius,
    double? height,
    EdgeInsets? padding,
    bool? disableButton,
  }) {
    return AppButton._(
      child: child,
      elevation: 0.0,
      backgroundColor: backgroundColor ?? const Color(0xFF444444),
      onTap: onTap,
      textStyle: textStyle ?? const TextStyle(fontWeight: FontWeight.w700),
      horizontalExpand: true,
      height: height,
      borderRadius: borderRadius ?? BorderRadius.circular(2),
      padding: padding ?? const EdgeInsets.symmetric(vertical: 5),
      disableButton: disableButton ?? false,
    );
  }

  factory AppButton.primary({
    required Function onTap,
    Widget? child,
    Color? backgroundColor,
    TextStyle? textStyle,
    OutlinedBorder? shape,
    BorderRadius? borderRadius,
    double? height,
    EdgeInsets? padding,
    bool? disableButton,
    bool? horizontalExpand,
    BorderSide? side,
  }) {
    return AppButton._(
        child: child,
        elevation: 0.0,
        backgroundColor: backgroundColor ?? AppColors.primaryButton,
        onTap: onTap,
        textStyle: textStyle ?? const TextStyle(fontWeight: FontWeight.w700),
        height: height,
        borderRadius: borderRadius,
        padding: padding,
        side: side,
        disableButton: disableButton ?? false,
        horizontalExpand: horizontalExpand ?? true);
  }

  factory AppButton.secondary(
      {required Function onTap,
      Color? backgroundColor,
      TextStyle? textStyle,
      OutlinedBorder? shape}) {
    return AppButton._(
        elevation: 0.0,
        backgroundColor: backgroundColor ?? AppColors.liteGrey,
        onTap: onTap,
        side: const BorderSide(
            color: AppColors.primary, width: 1, style: BorderStyle.solid),
        textStyle: textStyle ?? const TextStyle(fontWeight: FontWeight.w400));
  }

  final BorderRadius _defRadius = const BorderRadius.all(Radius.circular(2));
  final BorderSide _defSide = BorderSide.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: horizontalExpand ? double.infinity : null,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          elevation: MaterialStateProperty.all(elevation),
          shape: MaterialStateProperty.all(shape ??
              RoundedRectangleBorder(
                  side: side ?? _defSide,
                  borderRadius: borderRadius ?? _defRadius)),
          side: MaterialStateProperty.all(side),
          textStyle: MaterialStateProperty.all(textStyle),
          padding: MaterialStateProperty.all(padding ??
              const EdgeInsets.symmetric(vertical: 12, horizontal: 24)),
        ),
        onPressed: !disableButton
            ? () {
                onTap?.call();
              }
            : null,
        child: child,
      ),
    );
  }
}
