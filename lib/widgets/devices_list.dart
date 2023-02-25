import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/widgets/widgets.dart';

class DevicesList extends StatelessWidget {
  final List<DiscoveredDevice> devices;
  const DevicesList({Key? key, required this.devices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => DeviceListTile(
        device: devices[index],
      ),
      itemCount: devices.length,
    );
  }
}
