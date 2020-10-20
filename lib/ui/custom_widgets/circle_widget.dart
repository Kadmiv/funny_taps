import 'package:flutter/cupertino.dart';

class CirclePainter extends CustomPainter {
  static const CONST_RADIUS = 50.0;
  double radius = CONST_RADIUS;

  CirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..style = PaintingStyle.fill;
    //a circle
    canvas.drawCircle(Offset(0, 0), radius, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
