import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  final String title;
  final String content;
  final String closeButtonLabel;

  const AlertWidget({
    super.key,
    required this.title,
    required this.content,
    required this.closeButtonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          child: Text(closeButtonLabel),
          onPressed: () {
            Navigator.of(context).pop(); // Fechar o diálogo
          },
        ),
      ],
    );
  }
}
