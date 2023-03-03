part of 'ble_data_bloc.dart';

abstract class BleDataEvent extends Equatable {
  const BleDataEvent();

  @override
  List<Object> get props => [];
}

class OnReadyToWorkEvent extends BleDataEvent {
  final BleDataStatus status;
  final DiscoveredDevice device;

  const OnReadyToWorkEvent(this.status, this.device);
}

class OnDiscoverServices extends BleDataEvent {}
