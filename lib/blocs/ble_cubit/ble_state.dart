part of 'ble_cubit.dart';

enum BleStatus { initial, scanning, error }

class BleState extends Equatable {
  final BleScannerState scannerState;
  final BleStatus status;
  const BleState({required this.scannerState, required this.status});

  BleState copyWith({BleScannerState? scannerState, BleStatus? status}) =>
      BleState(
          scannerState: scannerState ?? this.scannerState,
          status: status ?? this.status);

  @override
  List<Object> get props => [scannerState, status];
}
