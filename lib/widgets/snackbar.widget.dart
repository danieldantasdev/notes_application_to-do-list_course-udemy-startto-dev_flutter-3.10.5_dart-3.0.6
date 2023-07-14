import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  const SnackBarWidget(
      {super.key,
      required this.content,
      required this.insertInPosition,
      required this.duration,
      required this.label});

  final String content;
  final String label;
  final int duration;
  final Function() insertInPosition;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(
        content!,
        style: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      action: SnackBarAction(
        textColor: Colors.tealAccent,
        label: label,
        onPressed: () => {insertInPosition},
      ),
      duration: Duration(seconds: duration),
    );
  }
}
