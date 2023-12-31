import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {

  String title;
  VoidCallback onTap;
   CustomButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(onPressed: onTap, 
      style: ElevatedButton.styleFrom(
       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
    foregroundColor: Colors.white, backgroundColor: Colors.red, // Text color
  ),
      child: Text(title)),
    );
  }
}