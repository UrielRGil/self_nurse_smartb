import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:self_nurse/widgets/widgets.dart';

import '../blocs/ble_data/ble_data_bloc.dart';

class DeviceDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BleDataBloc, BleDataState>(builder: (context, state) {
        if (state.status == BleDataStatus.initial && state.services.isEmpty) {
          return const Center(
            child: Text('No hay ningun dispositivo conectado'),
          );
        }

        if (state.status == BleDataStatus.searching) {
          return const Center(child: CircularProgressIndicator());
        }

        return DeviceServicesList(services: state.services);
      }),
      floatingActionButton: BlocBuilder<BleDataBloc, BleDataState>(
        builder: (context, state) {
          if (state.status != BleDataStatus.ready) {
            return const SizedBox();
          }
          return FadeInUp(
            child: FloatingActionButton(
              elevation: 0.0,
              onPressed: () {
                //TODO: Start discover services
                //TODO: Start listen SPO2 sensor
                context.read<BleDataBloc>().add(OnDiscoverServices());
              },
              child: const Icon(Icons.play_arrow_rounded),
            ),
          );
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }
}
