import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:self_nurse/blocs/ble_bloc/ble_bloc.dart' as ble;
import 'package:self_nurse/services/ble_device_interactor.dart';

part 'ble_data_event.dart';
part 'ble_data_state.dart';

class BleDataBloc extends Bloc<BleDataEvent, BleDataState> {
  final ble.BleBloc bleBloc;
  StreamSubscription<ble.BleState>? _bleStateSubscription;
  final BleDeviceInteractor bleDeviceInteractor;
  BleDataBloc(this.bleBloc, this.bleDeviceInteractor)
      : super(BleDataState(status: BleDataStatus.initial, services: [])) {
    on<BleDataEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OnReadyToWorkEvent>(_onReadyToWorkEvent);
    on<OnDiscoverServices>(_onDiscoverServices);

    _bleStateSubscription = bleBloc.stream.listen((bleBlocState) {
      if (bleBlocState.status == ble.BleStatus.connected) {
        add(OnReadyToWorkEvent(
            BleDataStatus.ready, bleBlocState.selectedDevice!));
      }
    });
  }

  void _onReadyToWorkEvent(
      OnReadyToWorkEvent event, Emitter<BleDataState> emit) {
    emit(state.copyWith(status: event.status, device: event.device));
  }

  void _onDiscoverServices(
      OnDiscoverServices event, Emitter<BleDataState> emit) async {
    emit(state.copyWith(status: BleDataStatus.searching));

    final services =
        await bleDeviceInteractor.discoverServices(state.device!.id);

    if (services.isEmpty) return;

    emit(state.copyWith(status: BleDataStatus.initial, services: services));
  }
}
