import 'package:flutter/material.dart';
import 'package:logger/logger.dart';



const hiveBox = "hiveBox";
const userExists = "userExists";
final logger = Logger();

successSnackBar(BuildContext context, String text) {
  var snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

errorSnackBar(BuildContext context, String text) {
  var snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

infoSnackBar(BuildContext context, String text) {
  var snackBar = SnackBar(
    backgroundColor: Colors.indigo,
    content: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    duration: const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
