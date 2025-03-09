import 'package:flutter/material.dart';


class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key, this.onLocationPressed,
  });
  final void Function()? onLocationPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: onLocationPressed,
          child: Icon(Icons.my_location),
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.location_on),
        ),
        SizedBox(width: 20),
        FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.location_disabled_rounded),
        ),
      ],
    );
  }
}