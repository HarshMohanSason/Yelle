
import 'package:flutter/material.dart';


class CustomTextForms extends StatelessWidget {
   const CustomTextForms(
      {super.key,
      required this.hintText,this.controller,
       required this.hideText,
      required this.icon,
      required this.validator});

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final IconData icon;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
        obscureText: hideText,
        decoration: InputDecoration(
      suffixIcon:  Icon(icon),
      hintText: hintText,
      hintStyle: const TextStyle(fontFamily: 'Plus_Jakarta_Sans'),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.grey
              .withOpacity(0.5), // Change the border color to your preference
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(0.5),
          // Change the focused border color to your preference
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
          // Change the error border color to your preference
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.red,
          // Change the focused error border color to your preference
          width: 2,
        ),
      ),
        ),
      validator: validator,
    );
  }
}
