import 'dart:convert';
import 'dart:io';

import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';


  Future<Position> _getPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(
            'Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
Future<String>GetAddress() async {
  Position position = await _getPosition();
  final coordinates = new Coordinates(position.latitude, position.longitude);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  /*print("${first.featureName}");
  print("featureName: "+first.featureName);
  print("addressLine: "+first.addressLine);
  print("adminArea: "+first.adminArea);
  print("countryName: "+first.countryName);
  print("locality: "+first.locality);
  print("thoroughfare: "+first.thoroughfare);
  print("subAdminArea: "+first.subAdminArea);
  print("subThoroughfare: "+first.subThoroughfare);*/
  return '${first.locality},${first.adminArea},${first.countryName}';
}

Future<Map<String,String>>GetInfoForNearbyPosts() async {
  Position position = await _getPosition();
  final coordinates = new Coordinates(position.latitude, position.longitude);
  var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  var first = addresses.first;
  print("${first.featureName}");
  print("featureName: "+first.featureName);
  print("addressLine: "+first.addressLine);
  print("adminArea: "+first.adminArea);
  print("countryName: "+first.countryName);
  print("locality: "+first.locality);
  print("thoroughfare: "+first.thoroughfare);
  print("subAdminArea: "+first.subAdminArea);
  Map<String,String> info ={
    "city":first.locality,"lat":position.latitude.toString(),"lng":position.longitude.toString(),"radius":"5"};

  return info;
}