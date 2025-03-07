import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';


class GeHomePage extends StatefulWidget {
  const GeHomePage({super.key});

  @override
  State<GeHomePage> createState() => _GeHomePageState();
}

class _GeHomePageState extends State<GeHomePage> {
  Position? _currentPosition;
  
  Future <void>  _getCurrentLocation()async{
    if(await _checkPermission()){
      if(await _isGpsEnabled()){
        ///one time
        _currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: LocationSettings(
            accuracy: LocationAccuracy.best,

          )
        );
        setState(() {

        });
      }else{
        await _requestGpsService();
      }
    }else{
      _requestPermission();
    }
  }


  Future <void>  _listenCurrentLocation()async{
    if(await _checkPermission()){
      if(await _isGpsEnabled()){
        _currentPosition = await Geolocator.getCurrentPosition(
            locationSettings: LocationSettings(
              accuracy: LocationAccuracy.best,
            )
        );
        setState(() {

        });
      }else{
        await _requestGpsService();
      }
    }else{
      _requestPermission();
    }
  }
  
  
  
  
Future<bool> _checkPermission() async{
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission== LocationPermission.always || permission == LocationPermission.whileInUse){
    return true;
  }
  return false;
}
Future<bool> _requestPermission() async{
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission== LocationPermission.always || permission == LocationPermission.whileInUse){
    return true;
  }
  return false;
}
Future<bool> _isGpsEnabled() async{
  return await Geolocator.isLocationServiceEnabled();
}
Future<void> _requestGpsService()async{
   await Geolocator.openLocationSettings();
}
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           floatingActionButton: FloatingActionButton(onPressed:_getCurrentLocation,
           child: Icon(Icons.location_on_outlined),
           ),


      body: Center(child: Text("data========$_currentPosition")),

    );
  }
}
