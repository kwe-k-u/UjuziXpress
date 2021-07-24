import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';



class CustomLoadingIndicator extends StatefulWidget {
  @override
  _CustomLoadingIndicatorState createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SizedBox(
      width: size.width * 0.07,
      height: size.width * 0.07,
      child: LoadingIndicator(
        colors: [Colors.black],
        indicatorType: Indicator.ballBeat,
      ),
    );
  }
}
