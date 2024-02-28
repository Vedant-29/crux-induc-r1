import 'package:flutter/material.dart';

class CustomNotchedShape extends CircularNotchedRectangle {
  @override
  Path getOuterPath(Rect host, Rect? guest) {
    // Custom shape logic for the notch
    const double sRadius = 0.0; // Adjust the radius as needed
    const double cRadius = 0.0; // Adjust the radius as needed

    final Path path = Path();

    path.moveTo(host.left, host.top);
    path.lineTo(guest!.left - cRadius, host.top);
    path.arcToPoint(
      Offset(guest.left, host.top + sRadius),
      radius: Radius.circular(sRadius),
      clockwise: false,
    );
    path.arcToPoint(
      Offset(guest.right, host.top),
      radius: Radius.circular(sRadius),
      clockwise: false,
    );
    path.lineTo(host.right, host.top);
    path.lineTo(host.right, host.bottom);
    path.lineTo(host.left, host.bottom);
    
    return path;
  }
}
