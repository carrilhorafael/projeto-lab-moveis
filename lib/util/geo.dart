import 'package:geolocator/geolocator.dart';

// Codigo abaixo for retirado de: https://pub.dev/packages/geolocator
// Explicação pode ser encontrada em: https://www.youtube.com/watch?v=TruOM8pB2_k
// A explicação inclui coisas que o site não fala sobre (permissões)

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator
      .checkPermission(); // Checks permission (doesn't ask for permission yet)
  if (permission == LocationPermission.denied) {
    // If it is denied,
    permission = await Geolocator
        .requestPermission(); // Asks for permission (has chance to choose "only once")
    if (permission == LocationPermission.denied) {
      // If denied once again
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
