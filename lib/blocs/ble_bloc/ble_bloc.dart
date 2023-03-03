import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/models/ble_scanner_state.dart';
import 'package:self_nurse/services/ble_device_connector.dart';

import '../../services/ble_scanner.dart';

part 'ble_event.dart';
part 'ble_state.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final BleScanner _bleScanner;
  final BleDeviceConnector _bleConnector;

  StreamSubscription<BleScannerState>? _subscriptionScanner;
  StreamSubscription<ConnectionStateUpdate>? _subscriptionConnector;

  BleBloc(this._bleScanner, this._bleConnector)
      : super(const BleState(
            status: BleStatus.initial,
            scannerState: BleScannerState(
                discoveredDevices: [], scanIsInProgress: false))) {
    on<BleEvent>((event, emit) {});
    on<OnStartScanner>(_onStartScanner);
    on<OnStopScanner>(_onStopScanner);
    on<OnScannerStateChanged>(_onScannerStateChanged);
    on<OnTryToConnectDevice>(_onTryToConnectDevice);
    on<OnConnectDeviceChanged>(_onConnectDeviceChanged);

    _subscriptionScanner = _bleScanner.state.listen((scannerState) async {
      await _scannerStateChanged(scannerState);
    });

    _subscriptionConnector = _bleConnector.state.listen((stateUpdate) async {
      if (stateUpdate.connectionState == DeviceConnectionState.connected) {
        add(OnConnectDeviceChanged(
            deviceId: stateUpdate.deviceId, status: BleStatus.connected));
      }
    });
  }

  void _onTryToConnectDevice(
      OnTryToConnectDevice event, Emitter<BleState> emit) async {
    emit(state.copyWith(
        status: BleStatus.connecting, selectedDevice: event.device));
    await _bleConnector.connect(event.device.id);
  }

  void _onConnectDeviceChanged(
      OnConnectDeviceChanged event, Emitter<BleState> emit) {
    emit(state.copyWith(status: event.status));
  }

  Future<void> _scannerStateChanged(BleScannerState scannerState) async {
    add(OnScannerStateChanged(scannerState));
  }

  void _onScannerStateChanged(
      OnScannerStateChanged event, Emitter<BleState> emit) async {
    final scannerState = event.scannerState;
    emit(state.copyWith(
        scannerState: scannerState,
        status: (scannerState.scanIsInProgress)
            ? BleStatus.discovering
            : BleStatus.initial));
  }

  void _onStartScanner(OnStartScanner event, Emitter<BleState> emit) {
    _bleScanner.startScan([]);
  }

  void _onStopScanner(OnStopScanner event, Emitter<BleState> emit) async {
    await _bleScanner.stopScan();
  }

  @override
  Future<void> close() {
    _subscriptionScanner?.cancel();
    return super.close();
  }
}
