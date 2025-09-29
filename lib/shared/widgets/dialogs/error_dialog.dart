import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String message,
  // VoidCallback? onRetry,
) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Error'),
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
