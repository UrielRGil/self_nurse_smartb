import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class DeviceListTile extends StatelessWidget {
  final DiscoveredDevice device;
  const DeviceListTile({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text((device.name.isEmpty) ? 'Desconocido' : device.name),
      subtitle: Text(device.id),
    );
  }
}
