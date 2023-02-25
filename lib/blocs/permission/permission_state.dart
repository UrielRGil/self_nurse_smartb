part of 'permission_bloc.dart';

enum PermissionStatus { unkwown, granted, denied, error }

class PermissionState extends Equatable {
  final PermissionStatus status;

  const PermissionState(this.status);

  PermissionState copyWith(PermissionStatus? status) =>
      PermissionState(status ?? this.status);

  @override
  List<Object> get props => [status];
}
