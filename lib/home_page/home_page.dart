
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late final GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition:CameraPosition(
          zoom: 16,
          target: LatLng(25.637609780792328,
          88.58675906812256)) ,
        onMapCreated: (GoogleMapController controller){
          _mapController = controller;
        },
        onTap: (LatLng latLng){
          debugPrint("Taped latLng==============: $latLng");
        },
        onLongPress: (LatLng latLng){
          debugPrint("Taped latLng==============: $latLng");
        },
      ),
    );
  }
}
