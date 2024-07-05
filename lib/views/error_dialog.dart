import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final Color backgroundColor;

  const ErrorDialog(
      {super.key, required this.errorMessage, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      shadowColor: backgroundColor,
      title: const Text(
        "Erreur",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      content: Text(
        errorMessage,
        textAlign: TextAlign.center,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
