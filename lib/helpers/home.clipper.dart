import 'package:flutter/material.dart';

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var controlPoint = Offset(size.width / 2, size.height);

    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, size.width, size.height / 2);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
