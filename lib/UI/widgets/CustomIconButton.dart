import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomLoadingIndicator.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';


class CustomIconButton extends StatefulWidget {
  final Function onPressed;
  final IconData icon;
  final Color color;
  final Stream<dynamic> loadStream;

  CustomIconButton({
    this.onPressed,
    this.icon = Icons.arrow_forward_outlined,
    this.color,
    this.loadStream
  });

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();

}

class _CustomIconButtonState extends State<CustomIconButton> with SingleTickerProviderStateMixin{
  AnimationController _animationController;



  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(8.0),
      color: widget.color,
      onPressed: widget.onPressed,
      child: StreamBuilder(
        stream: widget.loadStream,
        builder: (context,snapshot){


          if (snapshot.data == ButtonState.loading) {
            return Theme(
              data: ThemeData(accentColor: Colors.grey),
              child: Transform.scale(
                scale: 0.5,
                child: CustomLoadingIndicator(),
              ),
            );
          }

          return Icon(widget.icon, size: 32.0, color: Colors.white,);
        },
      ),
      shape: CircleBorder(),
    );
  }



  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}

