import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_nurse/blocs/ble_bloc/ble_bloc.dart';

import '../widgets/widgets.dart';

class DevicesListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BleBloc, BleState>(
        listener: (context, state) {
          if (state.status == BleStatus.connected) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Dispostivo conectado exitosamente'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        builder: (context, state) {
          if (state.scannerState.discoveredDevices.isEmpty &&
              state.status == BleStatus.initial) {
            return const EmptyListMessagge();
          } else if (state.status == BleStatus.discovering) {
            return Stack(
              children: [
                DevicesList(devices: state.scannerState.discoveredDevices),
                const Center(child: CircularProgressIndicator())
              ],
            );
          }
          return DevicesList(devices: state.scannerState.discoveredDevices);
        },
      ),
      floatingActionButton: BlocBuilder<BleBloc, BleState>(
        builder: (context, state) {
          if (state.status == BleStatus.discovering) {
            return FadeInRight(
              child: FloatingActionButton(
                  onPressed: () {
                    context.read<BleBloc>().add(OnStopScanner());
                  },
                  child: const Icon(Icons.stop_rounded)),
            );
          }
          return FadeInRight(
            child: FloatingActionButton(
              onPressed: () {
                context.read<BleBloc>().add(OnStartScanner());
              },
              child: const Icon(Icons.refresh_rounded),
            ),
          );
        },
      ),
    );
  }
}
