part of 'ble_data_bloc.dart';

enum BleDataStatus { initial, reading, error, ready, searching }

class BleDataState extends Equatable {
  final BleDataStatus status;
  DiscoveredDevice? device;
  final List<DiscoveredService> services;
  BleDataState({required this.status, required this.services, this.device});

  BleDataState copyWith(
          {BleDataStatus? status,
          DiscoveredDevice? device,
          List<DiscoveredService>? services}) =>
      BleDataState(
          status: status ?? this.status,
          device: device ?? this.device,
          services: services ?? this.services);

  @override
  List<Object?> get props => [status, device, services];
}
