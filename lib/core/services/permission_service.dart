import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<bool> isLocationPermissionGranted() async {
    var status = await Permission.location.status;
    return status.isGranted;
  }

  Future<void> requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      await Permission.storage.request();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
