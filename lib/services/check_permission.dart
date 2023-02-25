import 'package:permission_handler/permission_handler.dart';

class CheckPermissions {
  Future<bool> locationStatus() async {
    final isGranted = await Permission.location.status;

    return isGranted.isGranted ? true : false;
  }

  Future<bool> bluetoothStatus() async {
    final isGranted = await Permission.bluetooth.status;

    return isGranted.isGranted ? true : false;
  }

  Future<PermissionStatus> requestPermission(Permission permission) async =>
      await permission.request();
}
