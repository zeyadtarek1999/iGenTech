import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> openMap(double latitude, double longitude) async {
    final String googleMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    final Uri mapUri = Uri.parse(googleMapsUrl);

    try {
      if (await canLaunchUrl(mapUri)) {
        await launchUrl(mapUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not open Google Maps.';
      }
    } catch (e) {
      debugPrint('Failed to open Google Maps: $e');
      try {
        await launchUrl(mapUri, mode: LaunchMode.inAppWebView);
      } catch (error) {
        debugPrint('Failed to open Google Maps in browser: $error');
      }
    }
  }
}
