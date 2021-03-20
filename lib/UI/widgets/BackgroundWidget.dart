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
    Path lowerShape = Path();



    upperShape.moveTo(0,0); //top left point
    upperShape.lineTo(0, cy); // line to bottom left
    upperShape.lineTo(cx*2, cy); //line to bottom right
    upperShape.lineTo(cx * 2, 0); //line to top right
    upperShape.lineTo(0, 0); //line to top left
    upperShape.close();

    lowerShape.moveTo(0, cy ); // top left point
    lowerShape.lineTo(0, cy); // line to bottom left point
    lowerShape.cubicTo(cx * 0.8, cy *1.9, cx, cy * 1.5, cx *2, cy ); //curve to bottom right point
    lowerShape.lineTo(cx*2, cy * 0.4); // line to top right point
    lowerShape.cubicTo(cx* 2, cy*0.2, cx *0.6 , cy *0.3, 0, cy * 0.5); //curve to top left point


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
