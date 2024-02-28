import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';


class BlueBtn extends StatelessWidget {

  final String SubmitText;
  final Function()? onPressed;
  

  const BlueBtn({
    super.key,
    required this.SubmitText,
    required this.onPressed,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: SizedBox(
        width: double.infinity, 
        height: 45,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onSecondaryContainer,
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(SubmitText),
        ),
      ),
    );
  }
}