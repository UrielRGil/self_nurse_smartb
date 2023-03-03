import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class DeviceListTile extends StatelessWidget {
  final DiscoveredDevice device;
  final VoidCallback? onTap;
  const DeviceListTile({Key? key, required this.device, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text((device.name.isEmpty) ? 'Desconocido' : device.name),
      subtitle: Text(device.id),
    );
  }
}
