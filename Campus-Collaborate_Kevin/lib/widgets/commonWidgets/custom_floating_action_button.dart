import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function() onPressed;
  final Image icon;
  const CustomFloatingActionButton(
      {super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: icon,
    );
  }
}
