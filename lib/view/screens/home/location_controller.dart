import 'dart:async';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationController extends GetxController {
  final currentLatLng = Rxn<LatLng>();
  final currentAddress = RxnString();
  GoogleMapController? mapController;
  StreamSubscription<Position>? positionStream;

  @override
  void onInit() {
    super.onInit();
    _startLiveTracking();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  // Start live location tracking
  Future<void> _startLiveTracking() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        return;
      }
    }

    // Cancel existing stream if running
    positionStream?.cancel();

    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      final newLatLng = LatLng(position.latitude, position.longitude);
      currentLatLng.value = newLatLng;

      _getAddressFromCoordinates(position.latitude, position.longitude);

      // Animate map camera
      if (mapController != null) {
        mapController!.animateCamera(CameraUpdate.newLatLng(newLatLng));
      }
    });
  }

  // Manual refresh: fetch current location only once
  Future<void> refreshLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final newLatLng = LatLng(position.latitude, position.longitude);
      currentLatLng.value = newLatLng;

      _getAddressFromCoordinates(position.latitude, position.longitude);

      if (mapController != null) {
        mapController!.animateCamera(CameraUpdate.newLatLng(newLatLng));
      }
    } catch (e) {
      currentAddress.value = "Failed to fetch location";
    }
  }

  // Convert coordinates to human-readable address
  Future<void> _getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        final place = placemarks[0];
        currentAddress.value = [
          if (place.name != null && place.name!.isNotEmpty) place.name,
          if (place.street != null && place.street!.isNotEmpty) place.street,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality,
          if (place.postalCode != null && place.postalCode!.isNotEmpty)
            place.postalCode,
          if (place.administrativeArea != null &&
              place.administrativeArea!.isNotEmpty)
            place.administrativeArea,
          if (place.country != null && place.country!.isNotEmpty) place.country,
        ].join(', ');
        print('--- Placemark Details ---');
        print('name: ${place.name}');
        print('street: ${place.street}');
        print('subLocality: ${place.subLocality}');
        print('locality: ${place.locality}');
        print('postalCode: ${place.postalCode}');
        print('adminArea: ${place.administrativeArea}');
        print('country: ${place.country}');
      }
    } catch (e) {
      currentAddress.value = "Failed to get full address";
    }
  }

  @override
  void onClose() {
    positionStream?.cancel(); // Clean up stream
    super.onClose();
  }
}
