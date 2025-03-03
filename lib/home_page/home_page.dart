
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  late final GoogleMapController _mapController;
  final Set<Marker> _markers =<Marker> {
    Marker(
      markerId: MarkerId("my-home"),
      position:  LatLng(25.637609780792328,
          88.58675906812256),
      onTap: (){},
      infoWindow: InfoWindow(
          title: "My Home",
          onTap: (){}
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: MarkerId("my-Institute"),
      position:  LatLng(25.623264673628036, 88.6462415009737),
      onTap: (){},
      infoWindow: InfoWindow(
          title: "My Home",
          onTap: (){}
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    ),
    Marker(
      markerId: MarkerId("pick-location"),
      position: LatLng(25.633471232106796, 88.5511065647006),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      draggable: true,
      onDragStart: (LatLng latLng){
        debugPrint("Taped latLngOnDragStart==============: $latLng");
      },
      onDragEnd: (LatLng latLng){
        debugPrint("Taped latLngOnDragEnd==============: $latLng");
      },
    ),
  };
  final Set<Polyline> _polylines =<Polyline> {
    Polyline(
      polylineId: PolylineId("my-home"),
      points: [
        LatLng(25.634368995091165, 88.58862597495317),
        LatLng(25.634804271684096, 88.58377654105425),
        LatLng(25.637338517221107, 88.5846133902669),
        LatLng(25.636090746560857, 88.58661968261003)
      ],
      color: Colors.red,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      width: 3,
      jointType: JointType.round
    ),
  };
  final Set<Circle> _circles = <Circle>{
    Circle(
      circleId: CircleId("my-home"),
      center: LatLng(25.637609780792328,
          88.58675906812256),
      radius: 100,
      strokeWidth: 2,
      strokeColor: Colors.green,
      fillColor: Colors.yellow.shade50,
    )
  };
  final Set<Polygon> _polygons =<Polygon> {
    Polygon(
        polygonId: PolygonId("my-home"),
        points: [
          LatLng(25.63233163772115, 88.59098631888628),
          LatLng(25.630041533994767, 88.5869737342),
          LatLng(25.633088547247464, 88.58537513762712),
          LatLng(25.6339784539086, 88.58841139823198),
          LatLng(25.633312233649093, 88.59102923423052)

        ],
        fillColor: Colors.orange.shade50,
        strokeWidth: 2,
      onTap: (){
          print("tap polygon============");
      },

    ),
  };
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(
          icon: Icon(Icons.location_on_outlined),
          label: "Explore",
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "You",
        ),
        NavigationDestination(
          icon: Icon(Icons.add_location_alt_outlined),
          label: "Contribute",
        ),
      ]),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: (){
              _getLocation().then((value){
                print("value====================: ${value.latitude.toString()} + ${value.longitude.toString()}");
                _markers.add(
                  Marker(
                    markerId: MarkerId("current"),
                    position: LatLng(value.latitude, value.longitude), // লোকেশনের জন্য সঠিক প্যারামিটার
                    infoWindow: InfoWindow(title: "My Location"),
                  ),
                );
CameraPosition cameraPosition = CameraPosition(
  zoom: 16,
  target: LatLng(value.latitude, value.longitude),
);
_mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

              });
            },
            child: Icon(Icons.my_location),
          ),
          SizedBox(width: 20,),
          FloatingActionButton(
            onPressed: (){
              _addNewMarker();
            },
            child: Icon(Icons.location_on),
          ),
          SizedBox(width: 20,),
          FloatingActionButton(
            onPressed: (){
              _goBackMyHome();
          },
          child: Icon(Icons.my_location),
          ),
        ],
      ),
      body:Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          trafficEnabled: true,
          initialCameraPosition:CameraPosition(
            zoom: 16,
            target: LatLng(25.637609780792328,
                88.58675906812256),
          ),
          onMapCreated: (GoogleMapController controller){
            _mapController = controller;
          },
          onTap: (LatLng latLng){
            debugPrint("Taped latLngOnTap==============: $latLng");
          },
          onLongPress: (LatLng latLng){
            debugPrint("Taped latLngOnPress==============: $latLng");
          },
          markers:_markers,
          polylines: _polylines,
          circles: _circles,
          polygons: _polygons,
        ),
        Positioned(
          top: 40,
          left: 20,
          right: 20,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Location...",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.blue),
              ),
            ),
          ),
        ),
      ],
      ),
    );
  }


  void _addNewMarker() {
      _markers.add(
        Marker(
          markerId: MarkerId("pick-location"),
          position: LatLng(25.63750023072952, 88.57226751744747),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          draggable: true,
          onDragStart: (LatLng latLng){
            debugPrint("Taped latLngOnDragStart==============: $latLng");
          },
          onDragEnd: (LatLng latLng){
            debugPrint("Taped latLngOnDragEnd==============: $latLng");
          },
        ));
         setState(() {

         });
  }
void _goBackMyHome(){
    _mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      zoom: 16,
      target: LatLng(25.637609780792328,
          88.58675906812256),
    )));
}
Future<Position> _getLocation() async {
         await Geolocator.requestPermission().then((value)  {

         }
         ).onError((error, stackTrace) {
           print("error====================: $error");
         });
         return await Geolocator.getCurrentPosition();
    }


}
