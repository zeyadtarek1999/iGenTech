import 'dart:io';
import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    if (isSimulator()) {
      // Return a mock location for simulators
      return Position(
        latitude: 37.7749,
        longitude: -122.4194,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 1.0,
        heading: 1.0,
        speed: 1.0,
        speedAccuracy: 1.0,
        altitudeAccuracy: 1.0,
        headingAccuracy: 1.0,
        isMocked: true, // Indicate that the location is mocked
      );
    } else {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    }
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
