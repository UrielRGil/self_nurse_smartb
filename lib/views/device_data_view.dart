import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ble_bloc/ble_bloc.dart';

class DeviceDataView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BlocBuilder<BleBloc, BleState>(
        builder: (context, state) {
          if (state.status != BleStatus.connected) {
            return const SizedBox();
          }
          return FadeInUp(
            child: FloatingActionButton(
              elevation: 0.0,
              onPressed: () {},
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
