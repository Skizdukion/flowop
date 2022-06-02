import 'package:flutter/material.dart';
import 'string_extension.dart';
// import 'package:todo_app/utils/frequent_use_fuction.dart';

extension ExpandedSnackBar on SnackBar {
  static SnackBar statusSnackBar(BuildContext context, List<Widget> children,
      {Duration? duration, Color? color}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    return SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: children,
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color ?? Theme.of(context).primaryColorDark,
      duration: duration ?? const Duration(milliseconds: 4000),
      elevation: 2.0,
    );
  }

  static SnackBar successSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(
      context,
      <Widget>[
        Text(
          textMessage,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
        const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ],
      duration: const Duration(milliseconds: 1000),
    );
  }

  static SnackBar failureSnackBar(BuildContext context, String textMessage) {
    return statusSnackBar(
      context,
      <Widget>[
        Text(
          textMessage.cutAtLength(40),
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.white),
        ),
        const Icon(
          Icons.error_outline_sharp,
          color: Colors.white,
        ),
      ],
      color: Colors.red,
      duration: const Duration(milliseconds: 2000),
    );
  }
}
