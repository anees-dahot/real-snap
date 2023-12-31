import 'package:flutter/material.dart';

import '../../constants.dart';
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData myIcon;
  final String myLableText;
  final bool toHide;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.myIcon,
      required this.myLableText,
      this.toHide= false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: toHide,
      controller: controller,
      decoration: InputDecoration(
          icon: Icon(myIcon),
          labelText: myLableText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: borderColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: borderColor))),
              onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
