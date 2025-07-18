import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomToast extends StatelessWidget {
  final String message;

  CustomToast({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/Logo.png', // Replace with your app's logo asset
              height: 40,
              width: 40,
            ),
            SizedBox(width: 12.0), // Adjust the spacing between the logo and text
            Text(
              message,
                style:
                GoogleFonts.abel(fontWeight: FontWeight.bold, color: Color(0xff1034A6)),
            ),
          ],
        ),
      ),
    );
  }
}
