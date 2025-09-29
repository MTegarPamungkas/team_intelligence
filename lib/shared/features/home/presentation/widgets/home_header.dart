import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Home',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}