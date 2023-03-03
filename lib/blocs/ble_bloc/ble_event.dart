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

class OnTryToConnectDevice extends BleEvent {
  final DiscoveredDevice device;

  OnTryToConnectDevice(this.device);
}

class OnConnectDeviceChanged extends BleEvent {
  final String deviceId;
  final BleStatus status;
  const OnConnectDeviceChanged({required this.deviceId, required this.status});
}
