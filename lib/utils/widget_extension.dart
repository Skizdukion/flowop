import 'package:flowop/global/constant/color.dart';
import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget square(double size) {
    return rectangle(size, size);
  }

  Widget circle(double radius) {
    return Container(
      width: radius,
      height: radius,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: this,
    );
  }

  Widget rectangle(double width, double height) {
    return SizedBox(child: this, width: width, height: height);
  }

  Widget height(double size) {
    return SizedBox(
      height: size,
      child: this,
    );
  }

  Widget expand() {
    return Expanded(child: this);
  }

  Widget flexible() {
    return Flexible(child: this);
  }

  Widget rectAll(double radius,
      {Color? color, Color? borderColor, double? borderWidth}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: Container(
        child: this,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            border: Border.all(
                color: borderColor ?? Colors.white, width: borderWidth ?? 0)),
      ),
    );
  }

  Widget center() {
    return Center(
      child: this,
    );
  }

  Widget inkTap({
    required Function onTap,
    BorderRadiusGeometry borderRadius = BorderRadius.zero,
    Color? color,
    Color? splashColor,
  }) {
    return Container(
      color: color,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: splashColor,
          onTap: () => onTap.call(),
          customBorder: RoundedRectangleBorder(
            borderRadius: borderRadius,
          ),
          child: this,
        ),
      ),
    );
  }

  Widget columnFormLayoutBuilder() {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: this,
        ),
      ],
    );
  }

  Widget nullableInkTap({required Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap.call();
      },
      child: this,
    );
  }

  Widget marg([double? a, double? b, double? c, double? d]) {
    EdgeInsets mPad;

    if (d != null) {
      mPad = EdgeInsets.only(left: a!, right: b!, top: c!, bottom: d);
    } else if (c != null) {
      mPad = EdgeInsets.only(left: a!, right: b!, top: c);
    } else if (b != null) {
      mPad = EdgeInsets.symmetric(vertical: a!, horizontal: b);
    } else if (a != null) {
      mPad = EdgeInsets.all(a);
    } else {
      mPad = EdgeInsets.zero;
    }

    return Container(
      margin: mPad,
      child: this,
    );
  }

  Widget pad([double? a, double? b, double? c, double? d]) {
    EdgeInsets mPad;

    if (d != null) {
      mPad = EdgeInsets.only(left: a!, right: b!, top: c!, bottom: d);
    } else if (c != null) {
      mPad = EdgeInsets.only(left: a!, right: b!, top: c);
    } else if (b != null) {
      mPad = EdgeInsets.symmetric(vertical: a!, horizontal: b);
    } else if (a != null) {
      mPad = EdgeInsets.all(a);
    } else {
      mPad = EdgeInsets.zero;
    }

    return Padding(
      padding: mPad,
      child: this,
    );
  }

  Widget alignEndInColumn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        this,
      ],
    );
  }

  Widget align(AlignmentGeometry alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Widget unfocus() {
    return GestureDetector(
      onTap: () {
        if (primaryFocus != null) {
          primaryFocus!.unfocus();
        }
      },
      child: this,
    );
  }
}

class _TextWidgetBuilder {
  late String text;
  TextOverflow? _overflow;
  FontWeight _fontWeight = FontWeight.w500;
  TextAlign _textAlign = TextAlign.start;
  Color _color = Colors.black;
  Color _fillColor = Colors.transparent;
  FontStyle? _fontStyle;
  double? _fontSize;

  // ignore: unused_field
  double? _height;
  int? _maxLines;

  // ignore: unused_field
  int? _maxLength;

  _TextWidgetBuilder(this.text);

  _TextWidgetBuilder weight(FontWeight value) {
    _fontWeight = value;
    return this;
  }

  _TextWidgetBuilder align(TextAlign value) {
    _textAlign = value;
    return this;
  }

  _TextWidgetBuilder color(Color value) {
    _color = value;
    return this;
  }

  _TextWidgetBuilder fillColor(Color value) {
    _fillColor = value;
    return this;
  }

  _TextWidgetBuilder fStl(FontStyle value) {
    _fontStyle = value;
    return this;
  }

  _TextWidgetBuilder fSize(double value) {
    _fontSize = value;
    return this;
  }

  _TextWidgetBuilder lines(int? value) {
    _maxLines = value;
    return this;
  }

  _TextWidgetBuilder overflow(TextOverflow? value) {
    _overflow = value;
    return this;
  }

  _TextWidgetBuilder multipleLines() {
    _maxLines = null;
    return this;
  }

  _TextWidgetBuilder center() {
    _textAlign = TextAlign.center;
    return this;
  }

  _TextWidgetBuilder lHeight(double lineHeight) {
    _height = lineHeight;
    return this;
  }

  Text build() {
    return Text(
      text,
      style: TextStyle(
        color: _color,
        backgroundColor: _fillColor,
        fontSize: _fontSize ?? 12,
        fontWeight: _fontWeight,
        fontStyle: _fontStyle ?? FontStyle.normal,
        height: _height != null ? _height! / (_fontSize ?? 12) : (16 / 12),
      ),
      textAlign: _textAlign,
      maxLines: _maxLines,
      overflow: _overflow,
    );
  }
}

extension TextBuilderExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  _TextWidgetBuilder plain() {
    return _TextWidgetBuilder(this);
  }

  _TextWidgetBuilder bold() {
    return _TextWidgetBuilder(this).weight(FontWeight.w700);
  }

  _TextWidgetBuilder lite() {
    return _TextWidgetBuilder(this).weight(FontWeight.w300);
  }

  _TextWidgetBuilder plainErr() {
    return plain().color(Colors.red);
  }

  _TextWidgetBuilder boldErr() {
    return bold().color(Colors.red);
  }

  _TextWidgetBuilder liteErr() {
    return bold().color(Colors.red);
  }

  _TextWidgetBuilder plainW() {
    return plain().color(Colors.white);
  }

  _TextWidgetBuilder boldW() {
    return bold().color(Colors.white);
  }

  _TextWidgetBuilder liteW() {
    return bold().color(Colors.white);
  }

  _TextWidgetBuilder plainGrey() {
    return plain().color(AppColors.liteGrey);
  }

  _TextWidgetBuilder boldGrey() {
    return bold().color(AppColors.liteGrey);
  }

  _TextWidgetBuilder liteGrey() {
    return bold().color(AppColors.liteGrey);
  }

  _TextWidgetBuilder plainPri() {
    return plain().color(AppColors.primary);
  }

  _TextWidgetBuilder boldPri() {
    return bold().color(AppColors.primary);
  }

  Text mainTitle() {
    return bold()
        .fSize(16)
        .lines(1)
        .color(AppColors.primary)
        .align(TextAlign.center)
        .b();
  }

  Text secondaryTitle() {
    return bold()
        .fSize(16)
        .lines(1)
        .color(Colors.black)
        .align(TextAlign.center)
        .b();
  }

  Text title() {
    return plain().fSize(14).lines(1).color(AppColors.neutralGray).b();
  }

  Text mainDesc() {
    return plain().fSize(14).multipleLines().color(AppColors.primary).b();
  }

  Text desc() {
    return plain().fSize(14).multipleLines().color(Colors.black).b();
  }

  Text titleText18() {
    return plain()
        .fSize(18)
        .weight(FontWeight.w500)
        .lines(1)
        .color(AppColors.primary)
        .b();
  }

  Text text12() {
    return plain()
        .fSize(12)
        .lHeight(16)
        .multipleLines()
        .weight(FontWeight.w500)
        .center()
        .color(AppColors.textNeutral)
        .overflow(TextOverflow.ellipsis)
        .b();
  }

  Text descColor({Color? color, FontWeight? fontWeight}) {
    return plain()
        .fSize(12)
        .lHeight(16)
        .multipleLines()
        .weight(fontWeight ?? FontWeight.w500)
        .center()
        .color(color ?? Colors.white)
        .b();
  }

  Text secondaryDescColor({Color? color, FontWeight? fontWeight}) {
    return plain()
        .fSize(14)
        .lHeight(20)
        .multipleLines()
        .weight(fontWeight ?? FontWeight.w500)
        .color(color ?? AppColors.grayText)
        .center()
        .b();
  }

  Text buttonTitle() {
    return bold().fSize(14).lines(1).color(Colors.white).b();
  }

  Text disableButtonTitle() {
    return bold().fSize(14).lines(1).color(Colors.grey).b();
  }

  Text appBarTitle() {
    return plain()
        .weight(FontWeight.w500)
        .fSize(16)
        .lHeight(24)
        .lines(1)
        .color(AppColors.textNeutral)
        .b();
  }
}

extension WidgetStateExtension on State {
  double get maxW => MediaQuery.of(context).size.width;

  double get maxH => MediaQuery.of(context).size.height;
}

extension WidgetContextExtension on BuildContext {
  double get maxW => MediaQuery.of(this).size.width;

  double get maxH => MediaQuery.of(this).size.height;
}

extension TextExtension on _TextWidgetBuilder {
  Text b() {
    return build();
  }
}
