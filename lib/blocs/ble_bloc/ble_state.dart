part of 'ble_bloc.dart';

enum BleStatus { initial, discovering, connecting, connected, errror }

class BleState extends Equatable {
  final BleScannerState scannerState;
  final DiscoveredDevice? selectedDevice;
  final BleStatus status;
  const BleState(
      {required this.scannerState, required this.status, this.selectedDevice});

  BleState copyWith(
          {BleScannerState? scannerState,
          BleStatus? status,
          DiscoveredDevice? selectedDevice}) =>
      BleState(
          scannerState: scannerState ?? this.scannerState,
          status: status ?? this.status,
          selectedDevice: selectedDevice ?? this.selectedDevice);

  @override
  List<Object?> get props => [scannerState, status, selectedDevice];
}
