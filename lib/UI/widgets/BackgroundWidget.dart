import 'package:flutter/material.dart';


class BackgroundWidget extends StatelessWidget {
  final Widget child;

  BackgroundWidget({this.child});


  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: child,
      painter: BackgroundPainter(),
    );
  }
}



class BackgroundPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width *0.5;
    final double cy = size.height *0.5;

    Paint lighterPurple = new Paint()
      ..color = Color.fromRGBO(103, 58, 108, 100)
      ..style = PaintingStyle.fill
      ..shader = RadialGradient( colors: [ Colors.deepPurple, Colors.deepPurple ], ).createShader(Rect.fromCircle( center: Offset.zero, radius: 2, ))
      ..strokeWidth = 2;


    Paint deepPurple = new Paint()
      ..color = Color.fromRGBO(90, 30, 98, 1)
      ..style = PaintingStyle.fill
      ..shader = RadialGradient( colors: [ Colors.deepPurple, Colors.deepPurple ], ).createShader(Rect.fromCircle( center: Offset.zero, radius: 2, ))
      ..strokeWidth = 2;


    Path upperShape = Path();
    upperShape.moveTo(0,0); //correct
    upperShape.lineTo(0, cy);
    upperShape.lineTo(cx*2, cy);
    upperShape.lineTo(cx * 2, 0);
    upperShape.lineTo(0, 0);
    upperShape.close();

    Path lowerShape = Path();
    lowerShape.moveTo(0,cy * 1.3); //correct
    lowerShape.cubicTo(cx *-0.8, -cy *1.2 , -cx *0.5 , cy * 3, cx * 2.0, cy  ); //correct
    lowerShape.lineTo(cx * 2, cy * 0.4);
    lowerShape.cubicTo(cx * -1.0, cy * 0.4, -cx, cy * 0.8, 0, cy* 0.7);
    lowerShape.close();
    
    canvas.drawPath(upperShape, lighterPurple);
    canvas.drawPath(lowerShape, deepPurple);

  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}



class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {




  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
