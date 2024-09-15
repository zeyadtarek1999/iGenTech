import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  Future<Position?> getCurrentLocation() async {
    if (await Permission.location.isGranted) {
      try {
        return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      } catch (e) {
        debugPrint('Error getting location: $e');
        return null;
      }
    } else {
      await Permission.location.request();
      if (await Permission.location.isGranted) {
        try {
          return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        } catch (e) {
          debugPrint('Error getting location: $e');
          return null;
        }
      }
      return null;
    }
  }
}
