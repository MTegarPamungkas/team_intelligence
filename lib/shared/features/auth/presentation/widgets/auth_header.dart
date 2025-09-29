import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Auth',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}