import 'package:flutter/material.dart';

class SplashHeader extends StatelessWidget {
  const SplashHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Splash',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}