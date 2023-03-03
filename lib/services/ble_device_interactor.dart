import 'dart:async';
import 'dart:developer';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleDeviceInteractor {
  final FlutterReactiveBle ble;
  BleDeviceInteractor({required this.ble});

  Future<List<DiscoveredService>> discoverServices(String deviceId) async {
    try {
      log('Start discovering services for: $deviceId');
      final result = await ble.discoverServices(deviceId);
      log('Discovering services finished');
      return result;
    } on Exception catch (e) {
      log('Error occured when discovering services: $e');
      rethrow;
    }
  }

  Future<List<int>> readCharacteristic(
      QualifiedCharacteristic characteristic) async {
    try {
      final result = await ble.readCharacteristic(characteristic);

      log('Read ${characteristic.characteristicId}: value = $result');
      return result;
    } on Exception catch (e, s) {
      log(
        'Error occured when reading ${characteristic.characteristicId} : $e',
      );
      // ignore: avoid_print
      log(s.toString());
      rethrow;
    }
  }

  Future<void> writeCharacterisiticWithResponse(
      QualifiedCharacteristic characteristic, List<int> value) async {
    try {
      log('Write with response value : $value to ${characteristic.characteristicId}');
      await ble.writeCharacteristicWithResponse(characteristic, value: value);
    } on Exception catch (e, s) {
      log(
        'Error occured when writing ${characteristic.characteristicId} : $e',
      );
      // ignore: avoid_print
      log(s.toString());
      rethrow;
    }
  }

  Future<void> writeCharacterisiticWithoutResponse(
      QualifiedCharacteristic characteristic, List<int> value) async {
    try {
      await ble.writeCharacteristicWithoutResponse(characteristic,
          value: value);
      log('Write without response value: $value to ${characteristic.characteristicId}');
    } on Exception catch (e, s) {
      log(
        'Error occured when writing ${characteristic.characteristicId} : $e',
      );
      // ignore: avoid_print
      log(s.toString());
      rethrow;
    }
  }

  Stream<List<int>> subScribeToCharacteristic(
      QualifiedCharacteristic characteristic) {
    log('Subscribing to: ${characteristic.characteristicId} ');
    return ble.subscribeToCharacteristic(characteristic);
  }
}
