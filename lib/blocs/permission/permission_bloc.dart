import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:self_nurse/services/check_permission.dart';

part 'permission_event.dart';
part 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  final CheckPermissions _checkPermissions;
  PermissionBloc(this._checkPermissions)
      : super(const PermissionState(PermissionStatus.unkwown)) {
    on<PermissionEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnCheckPermissionStatusEvent>(_onCheckPermissionStatusEvent);
    on<OnRequestPermissionEvent>(_onRequestPermissionEvent);
    on<OnPermissionStatusChanged>(_onPermissionStatusChanged);
  }

  void _onCheckPermissionStatusEvent(
      OnCheckPermissionStatusEvent event, Emitter<PermissionState> emit) async {
    final locationStatus = await _checkPermissions.locationStatus();
    final bluetoothScanStatus = await _checkPermissions.bluetoothStatus();
    if (!locationStatus) {
      add(const OnRequestPermissionEvent(Permission.location));
      return;
    }
    if (!bluetoothScanStatus) {
      add(const OnRequestPermissionEvent(Permission.bluetoothScan));
      add(const OnRequestPermissionEvent(Permission.bluetoothConnect));
      return;
    }
    add(const OnPermissionStatusChanged(PermissionStatus.granted));
  }

  void _onRequestPermissionEvent(
      OnRequestPermissionEvent event, Emitter<PermissionState> emit) async {
    final resp = await _checkPermissions.requestPermission(event.permission);

    if (resp.isGranted) {
      emit(state.copyWith(PermissionStatus.granted));
    } else {
      emit(state.copyWith(PermissionStatus.denied));
    }
  }

  void _onPermissionStatusChanged(
      OnPermissionStatusChanged event, Emitter<PermissionState> emit) async {}
}
