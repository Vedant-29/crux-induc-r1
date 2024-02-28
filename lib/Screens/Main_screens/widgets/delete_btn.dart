import 'package:flutter/material.dart';
import 'package:crux_induc/main.dart';



class RedBtn extends StatelessWidget {

  final String SubmitText;
  final Function()? onPressed;
  

  const RedBtn({
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
        height: 55,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(   
            backgroundColor: Colors.white,
            foregroundColor: Color.fromARGB(255, 125, 25, 0),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: Color.fromARGB(255, 245, 172, 160),
                width: 2.0,
              ),
            ),
          ),
          child: Text(SubmitText),
        ),
      ),
    );
  }
}