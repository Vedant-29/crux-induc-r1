import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';

class AmountPill extends StatelessWidget {
  final Function()? onTap;
  final String pillText;
  final Color backgroundColor; // Add this line

  const AmountPill({
    required this.onTap, 
    required this.pillText,
    required this.backgroundColor, // And this line
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, 
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor, // Use the color here

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        pillText, 
        style: TextStyle(
          fontFamily: 'inter',
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}