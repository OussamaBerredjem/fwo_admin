import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fwo_admin/src/core/helper/utlis.dart';
import 'package:fwo_admin/src/presentation/models/user_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;

void initializeScreen() {
  if (isLoggedIn) {
    if ((userBox.get('user') as UserModel).type == 'admin') {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  } else {
    Get.offAllNamed('/login');
  }
}

Future<void> requestPermissions() async {
  final permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> determinePosition() async {
  requestPermissions();
  return Geolocator.getCurrentPosition();
}

getdistanceBetween(double lat1, double long1, double lat2, double long2) {
  double distance = Geolocator.distanceBetween(lat1, long1, lat2, long2);
  double distanceInKm = distance / 1000;
  return distanceInKm.toStringAsFixed(2);
}

openMapsSheet(context, double lat, double long) async {
  try {
    final coords = Coords(lat, long);
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Wrap(
            children: <Widget>[
              for (var map in availableMaps)
                ListTile(
                  onTap: () => map.showMarker(
                    coords: coords,
                    title: '',
                  ),
                  title: Text(map.mapName),
                  leading: SvgPicture.asset(
                    map.icon,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  } catch (e) {
    print(e);
  }
}
