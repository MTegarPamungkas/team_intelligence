import 'package:flutter/material.dart';

Future<void> showSuccessDialog(
  BuildContext context,
  String message,
  // VoidCallback? onRetry,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Success'),
      content: Text(message),
      actions: [
        // TextButton(onPressed: onRetry, child: const Text('Retry')),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
