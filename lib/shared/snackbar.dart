import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackBar {
  static void showToast(BuildContext ctx, String msg) {
    final scaffold = ScaffoldMessenger.of(ctx);
    scaffold.showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  static void showLoaderDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: Text('$text data...')),
        ],
      ),
    );

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showConfirmationDialog(
      BuildContext context, String text, VoidCallback? onPressed) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Konfirmasi"),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigator.of(context).pop(); // Tutup dialog
                  Get.back();
                },
                child: const Text("Tidak"),
              ),
              TextButton(
                onPressed: onPressed,
                child: const Text("Ya"),
              ),
            ],
          );
        });
  }
}
