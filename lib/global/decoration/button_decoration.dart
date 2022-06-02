import 'package:flutter/material.dart';

class AppButtonDecoration {
  static ButtonStyle authenticate1 = ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(8.0)),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(color: Colors.white))),
  );

  static ButtonStyle authenticate2 = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all<Color>(const Color.fromRGBO(249, 96, 96, 1)),
    padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(13.0)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(color: Colors.white))),
  );

  static ButtonStyle menu = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all<Color>(const Color.fromRGBO(96, 116, 249, 1)),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(color: Colors.white))),
  );
}