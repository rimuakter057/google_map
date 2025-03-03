import 'package:flutter/material.dart';
import 'package:google_map/home_page/home_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
   debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}