import 'dart:async';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {
  late GoogleMapController mapController;
  LatLng? currentPosition;
  List<LatLng> polylineCoordinates = [];
  StreamSubscription<Position>? positionStream;

  final markers = <Marker>{}.obs;
  final polylines = <Polyline>{}.obs;

  final searchResults = <Marker>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;


    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }


    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return;
      }
    }


    positionStream = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      LatLng newPosition = LatLng(position.latitude, position.longitude);

      if (currentPosition != null) {
        polylineCoordinates.add(currentPosition!);
      }

      currentPosition = newPosition;
      polylineCoordinates.add(newPosition);
      updateMap();
    });
  }

  void updateMap() {
    if (currentPosition != null) {
      markers.value = {
        Marker(
          markerId: MarkerId("current_location"),
          position: currentPosition!,
          infoWindow: InfoWindow(
            title: "My current location",
            snippet: "${currentPosition!.latitude}, ${currentPosition!.longitude}",
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        ),
      };

      polylines.value = {
        Polyline(
          polylineId: PolylineId("route"),
          color: const Color(0xFF2196F3),
          width: 5,
          points: polylineCoordinates,
        ),
      };

      mapController.animateCamera(CameraUpdate.newLatLng(currentPosition!));
    }
  }

  Future<void> searchLocation(String query) async {
    List<Location> locations = await locationFromAddress(query);
    if (locations.isNotEmpty) {
      LatLng searchPosition = LatLng(locations.first.latitude, locations.first.longitude);
      searchResults.value = {
        Marker(
          markerId: MarkerId("search_location"),
          position: searchPosition,
          infoWindow: InfoWindow(
            title: query,
            snippet: "${searchPosition.latitude}, ${searchPosition.longitude}",
          ),
        ),
      };
      mapController.animateCamera(CameraUpdate.newLatLng(searchPosition));
    }
  }

  Future<void> onMapTapped(LatLng tappedPosition) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(tappedPosition.latitude, tappedPosition.longitude);
    String locationName = placemarks.isNotEmpty ? placemarks.first.name ?? 'Unknown Location' : 'Unknown Location';

    markers.clear();
    markers.add(Marker(
      markerId: MarkerId(tappedPosition.toString()),
      position: tappedPosition,
      infoWindow: InfoWindow(
        title: locationName,
        snippet: "Latitude: ${tappedPosition.latitude}, Longitude: ${tappedPosition.longitude}",
      ),
    ));

    mapController.animateCamera(CameraUpdate.newLatLng(tappedPosition));
  }

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }
}
