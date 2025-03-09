import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLongScreen extends StatefulWidget {
  const ConvertLatLongScreen({super.key});

  @override
  State<ConvertLatLongScreen> createState() => _ConvertLatLongScreenState();
}

class _ConvertLatLongScreenState extends State<ConvertLatLongScreen> {
  String locationMessage = "Press the button to get location";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("convert your address"),),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(onPressed:   () async {
            // Adding try-catch block to prevent crashes and handle errors
            try {
              List<Placemark> placemarks = await placemarkFromCoordinates(25.6335, 88.5505);
              Placemark place = placemarks.first;

              // Updating locationMessage with the new data
              setState(() {
                locationMessage = "${place.locality}, ${place.country}";
              });
            } catch (e) {
              // In case of an error, display it in the UI
              setState(() {
                locationMessage = "Failed to get location";
              });
              print("Error: $e");
            }
          },

              style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: Size.fromWidth(double.infinity),
              ),

              child: Text("convert"))
        ],
      ),
    );
  }
}
