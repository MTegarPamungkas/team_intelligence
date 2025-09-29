import 'package:flutter/material.dart';

mixin NavigationMixin<T extends StatefulWidget> on State<T> {
  void navigateTo(String route) {
    Navigator.pushNamed(context, route);
  }
}
