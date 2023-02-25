import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_nurse/blocs/ble_bloc/ble_bloc.dart';
import 'package:self_nurse/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self Nurse'),
        actions: [Icon(Icons.wifi)],
      ),
      body: BlocBuilder<BleBloc, BleState>(
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
            return FloatingActionButton(
              onPressed: () {
                context.read<BleBloc>().add(OnStopScanner());
              },
              child: const Icon(Icons.stop_rounded),
            );
          }
          return FloatingActionButton(
              onPressed: () {
                context.read<BleBloc>().add(OnStartScanner());
              },
              child: const Icon(Icons.search_rounded));
        },
      ),
    );
  }
}
