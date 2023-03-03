import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/blocs/ble_bloc/ble_bloc.dart';
import 'package:self_nurse/widgets/widgets.dart';

import '../blocs/ble_bloc/ble_bloc.dart' as ble;

class DevicesList extends StatelessWidget {
  final List<DiscoveredDevice> devices;
  const DevicesList({Key? key, required this.devices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => BlocBuilder<ble.BleBloc, ble.BleState>(
        builder: (context, state) {
          return DeviceListTile(
            onTap: (state.status == ble.BleStatus.discovering)
                ? null
                : () {
                    context
                        .read<BleBloc>()
                        .add(OnTryToConnectDevice(devices[index]));
                  },
            device: devices[index],
          );
        },
      ),
      itemCount: devices.length,
    );
  }
}
