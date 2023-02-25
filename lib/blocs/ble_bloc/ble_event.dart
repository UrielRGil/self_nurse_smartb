part of 'ble_bloc.dart';

abstract class BleEvent extends Equatable {
  const BleEvent();

  @override
  List<Object> get props => [];
}

class OnStartScanner extends BleEvent {}

class OnStopScanner extends BleEvent {}

class OnScannerStateChanged extends BleEvent {
  final BleScannerState scannerState;

  OnScannerStateChanged(this.scannerState);
}
