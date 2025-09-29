import 'package:flutter/material.dart';

class NetworkIndicator extends StatelessWidget {
  final bool isConnected;

  const NetworkIndicator({super.key, required this.isConnected});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isConnected ? Icons.wifi : Icons.wifi_off,
      color: isConnected ? Colors.green : Colors.red,
    );
  }
}
