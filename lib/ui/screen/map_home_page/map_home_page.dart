import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/controller/map_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());
  MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Location Tracking (Geolocator)")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            ///search bar
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onSubmitted: (query) {
                mapController.searchLocation(query);
              },
            ),
          ),
          Expanded(
            ///google map
            child: Obx(
                  () => mapController.isLocationLoading.value
                  ? Center(child: CircularProgressIndicator())
                  : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: mapController.currentPosition ??
                      LatLng(23.8103, 90.4125),
                  zoom: 15,
                ),
                markers: {
                  ...mapController.markers.value,
                  ...mapController.searchResults.value,
                },
                polylines: mapController.polylines.value,
                onMapCreated: mapController.onMapCreated,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onTap: mapController.onMapTapped,
              ),
            ),
          ),
        ],
      ),
      ////current location button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapController.currentPosition != null) {
            mapController.mapController.animateCamera(
              CameraUpdate.newLatLng(mapController.currentPosition!),
            );
          }
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
