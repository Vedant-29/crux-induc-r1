import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';


class InputTextFieldWithoutPrefix extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final IconData? prefixIcon;
  final EdgeInsetsGeometry? labelPadding;
  
  const InputTextFieldWithoutPrefix({
    Key? key,
    required this.controller,
    required this.obscureText,
    required this.labelText,
    this.labelPadding,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        textAlignVertical: TextAlignVertical.top,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          contentPadding: labelPadding, // Adjust vertical padding
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.shadow,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: theme.colorScheme.shadow,
            ),
          ),
          labelText: labelText,
          labelStyle: TextStyle(
            color: theme.colorScheme.shadow,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefix: prefixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.all(15.0), // Adjust padding as needed
                child: Icon(
                  prefixIcon,
                ),
              ),
        ),
        cursorColor: theme.colorScheme.shadow,
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
