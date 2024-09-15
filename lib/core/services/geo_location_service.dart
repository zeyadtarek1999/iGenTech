import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool isPermissionGranted = await _checkLocationPermission();

    if (isPermissionGranted) {
      if (isSimulator()) {
        // Use a default location for simulator (e.g., San Francisco)
        return Position(
          latitude: 37.7749,
          longitude: -122.4194,
          timestamp: DateTime.now(),
          accuracy: 1.0,
          altitude: 1.0,
          heading: 1.0,
          speed: 1.0,
          speedAccuracy: 1.0,
          altitudeAccuracy: 1.0, // Added required parameter
          headingAccuracy: 1.0, // Added required parameter
          isMocked: false, // Added required parameter
        );
      } else {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }
    } else {
      // If permission is denied, return null or handle accordingly
      return null;
    }
  }

  Future<bool> _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      return true;
    }

    return false; // Permission was denied or denied forever
  }

  bool isSimulator() {
    if (Platform.isAndroid) {
      return !Platform.environment.containsKey('ANDROID_BOOTLOGO') &&
          Platform.environment.containsKey('ANDROID_EMULATOR');
    } else if (Platform.isIOS) {
      return Platform.environment.containsKey('SIMULATOR_DEVICE_NAME');
    }
    return false;
  }
}
