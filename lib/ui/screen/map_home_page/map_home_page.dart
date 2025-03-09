import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controller/location_controller.dart';

class MapScreen extends StatelessWidget {
  final MapController mapController = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Location Tracking (Geolocator)")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
            child: Obx(() => GoogleMap(
              initialCameraPosition: CameraPosition(
                // Set camera position to current location if available
                target: mapController.currentPosition ?? LatLng(23.8103, 90.4125), // Default Dhaka if location is null
                zoom: 15,
              ),
              markers: {...mapController.markers.value, ...mapController.searchResults.value},
              polylines: mapController.polylines.value,
              onMapCreated: mapController.onMapCreated,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onTap: mapController.onMapTapped, // Add tap listener for adding markers
            )),
          ),
        ],
      ),
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
