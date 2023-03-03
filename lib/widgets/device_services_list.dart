import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/widgets/widgets.dart';

class DeviceServicesList extends StatelessWidget {
  final List<DiscoveredService> services;

  const DeviceServicesList({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => ServiceTile(service: services[index]),
      itemCount: services.length,
    );
  }
}
