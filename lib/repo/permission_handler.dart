import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static Future<bool> getStoragePermission() async {
    var storagePermissionStatus = await Permission.storage.request();
    var locationPermissionStatus = await Permission.location.request();
    var cameraPermissionStatus = await Permission.camera.request();
    debugPrint('storage Permission: $storagePermissionStatus' );
     debugPrint('location Permission: $locationPermissionStatus' );
      debugPrint('camera Permission: $cameraPermissionStatus' );

    if (storagePermissionStatus == PermissionStatus.granted) {
      return true;
    } else if (storagePermissionStatus == PermissionStatus.permanentlyDenied) {
      return await openAppSettings();
    } else {
      return false;
    }
  }
}
