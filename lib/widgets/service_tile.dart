import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ServiceTile extends StatelessWidget {
  final DiscoveredService service;

  const ServiceTile({super.key, required this.service});
  @override
  Widget build(BuildContext context) {
    final characteristics = service.characteristicIds
        .map((c) => ListTile(
              subtitle: Text(c.toString()),
            ))
        .toList();
    return ExpansionTile(
        title: const Text('Service uuid:'),
        subtitle: Text('${service.serviceId}'),
        children: characteristics);
  }
}
