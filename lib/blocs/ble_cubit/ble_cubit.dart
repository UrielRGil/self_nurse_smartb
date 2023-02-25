import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/models/ble_scanner_state.dart';
import 'package:self_nurse/services/ble_scanner.dart';

part 'ble_state.dart';

class BleCubit extends Cubit<BleState> {
  final BleScanner _bleScanner;
  StreamSubscription<BleScannerState>? _subscription;

  BleCubit(this._bleScanner)
      : super(const BleState(
            scannerState:
                BleScannerState(discoveredDevices: [], scanIsInProgress: false),
            status: BleStatus.initial));

  void startScan() async {
    emit(state.copyWith(
        status: BleStatus.scanning,
        scannerState: const BleScannerState(
            discoveredDevices: [], scanIsInProgress: true)));
    log('Start scann');
    _bleScanner.startScan([]);
    _subscription = _bleScanner.state.listen((devices) {
      emit(state.copyWith(scannerState: devices));
    });
  }

  void stopScan() async {
    emit(state.copyWith(status: BleStatus.initial));
    await _bleScanner.stopScan();
    await _subscription?.cancel();

    _subscription = null;
  }
}
