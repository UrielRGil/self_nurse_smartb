part of 'permission_bloc.dart';

abstract class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object> get props => [];
}

class OnPermissionStatusChanged extends PermissionEvent {
  final PermissionStatus status;

  const OnPermissionStatusChanged(this.status);
}

class OnCheckPermissionStatusEvent extends PermissionEvent {}

class OnRequestPermissionEvent extends PermissionEvent {
  final Permission permission;

  const OnRequestPermissionEvent(this.permission);
}
