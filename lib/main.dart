import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/blocs/ble_bloc/ble_bloc.dart';
import 'package:self_nurse/blocs/ble_data/ble_data_bloc.dart';
import 'package:self_nurse/blocs/permission/permission_bloc.dart';
import 'package:self_nurse/pages/pages.dart';
import 'package:self_nurse/services/ble_device_interactor.dart';
import 'package:self_nurse/services/ble_scanner.dart';
import 'package:self_nurse/services/check_permission.dart';

import 'services/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider(
    create: (context) => PermissionBloc(CheckPermissions()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<PermissionBloc>().add(OnCheckPermissionStatusEvent());
    final _flutterReactiveBle = FlutterReactiveBle();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Self Nurse',
      home: BlocBuilder<PermissionBloc, PermissionState>(
        builder: (context, state) {
          if (state.status == PermissionStatus.denied) {
            return PermissionInfoPage();
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => BleBloc(BleScanner(_flutterReactiveBle),
                    BleDeviceConnector(ble: _flutterReactiveBle)),
              ),
              BlocProvider(
                create: (context) => BleDataBloc(context.read<BleBloc>(),
                    BleDeviceInteractor(ble: _flutterReactiveBle)),
              ),
            ],
            child: HomePage(),
          );
        },
      ),
      theme: ThemeData(useMaterial3: true),
    );
  }
}
