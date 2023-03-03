import 'package:flutter/material.dart';

class ConnectionStatus extends StatelessWidget {
  final bool status;

  const ConnectionStatus({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: status ? Colors.green : Colors.red),
    );
  }
}
