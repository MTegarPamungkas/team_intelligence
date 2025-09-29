import 'package:flutter/material.dart';

class ProgressIndicator extends StatelessWidget {
  final double value;

  const ProgressIndicator({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(value: value);
  }
}
