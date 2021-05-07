import 'package:geolocator/geolocator.dart';

class LocationProvider {
  static Future<Map<String, double>> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium);

    return {'lat': location.latitude, 'lon': location.longitude};
  }
}
