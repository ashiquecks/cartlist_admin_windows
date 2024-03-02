import 'package:flutter/material.dart';

showAlertDialogOne({
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: const [
      CircularProgressIndicator(
        color: Colors.green,
      ),
      SizedBox(width: 10),
      Text("Loading...")
    ],
  ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}

showAlertDialogTwo({
  required BuildContext context,
}) {
  AlertDialog alert = AlertDialog(
      content: Row(
    children: const [
      Icon(
        Icons.check_circle,
        size: 25,
        color: Colors.green,
      ),
      Text("Successfully Uploaded")
    ],
  ));

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.of(context).pop(true);
      });
      return alert;
    },
  );
}
