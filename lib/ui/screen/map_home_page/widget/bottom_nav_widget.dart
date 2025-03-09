import 'package:flutter/material.dart';


class BottomNavWidget extends StatelessWidget {

  const BottomNavWidget({
    super.key,
    required this.onDestinationSelected,
    required this.selectedIndex,
  });

  final Function(int) onDestinationSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
   onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.location_on_outlined),
          label: "Explore",
        ),
        NavigationDestination(icon: Icon(Icons.person), label: "You"),
        NavigationDestination(
          icon: Icon(Icons.add_location_alt_outlined),
          label: "Contribute",
        ),
      ],
    );
  }
}