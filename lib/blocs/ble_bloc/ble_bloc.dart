import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:self_nurse/models/ble_scanner_state.dart';

import '../../services/ble_scanner.dart';

part 'ble_event.dart';
part 'ble_state.dart';

class BleBloc extends Bloc<BleEvent, BleState> {
  final BleScanner _bleScanner;
  StreamSubscription<BleScannerState>? _subscription;

  BleBloc(this._bleScanner)
      : super(const BleState(
            status: BleStatus.initial,
            scannerState: BleScannerState(
                discoveredDevices: [], scanIsInProgress: false))) {
    on<BleEvent>((event, emit) {});
    on<OnStartScanner>(_onStartScanner);
    on<OnStopScanner>(_onStopScanner);
    on<OnScannerStateChanged>(_onScannerStateChanged);

    _subscription = _bleScanner.state.listen((scannerState) async {
      await _scannerStateChanged(scannerState);
    });
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
    _subscription?.cancel();
    return super.close();
  }
}
