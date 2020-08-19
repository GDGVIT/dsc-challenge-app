import 'package:daily_mcq/src/utils/global_themes.dart';
import 'package:flutter/material.dart';

SnackBar getMySnackBar(String message, {Color color}) {
  final snackbar = SnackBar(
    elevation: 0.5,
    content: Text(
      message,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
      ),
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color ?? primaryColor,
  );
  return snackbar;
}
