import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

abstract class NavigationServiceInterface {
  void navigateTo(String route);
  void navigateAndReplace(String route);
  void navigateAndClearStack(String route);
  void showErrorSnackBar(String message);
}

class NavigationService implements NavigationServiceInterface {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void navigateTo(String route) {
    final context = navigatorKey.currentContext;
    print("🧭 NavigationService: navigateTo $route");
    if (context != null) {
      context.push(route);
    } else {
      print("❌ Context is null!");
    }
  }

  @override
  void navigateAndReplace(String route) {
    final context = navigatorKey.currentContext;
    print("🧭 NavigationService: navigateAndReplace $route");
    if (context != null) {
      context.pushReplacement(route);
    } else {
      print("❌ Context is null!");
    }
  }

  @override
  void navigateAndClearStack(String route) {
    final context = navigatorKey.currentContext;
    print("🧭 NavigationService: navigateAndClearStack $route");
    if (context != null) {
      context.go(route);
    } else {
      print("❌ Context is null!");
    }
  }

  @override
  void showErrorSnackBar(String message) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}
