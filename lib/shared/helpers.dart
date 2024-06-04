import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:espot/shared/theme.dart';
import 'package:intl/intl.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}

String dateToMonthDate(DateTime date) {
  return DateFormat('MMMM dd').format(date);
}
