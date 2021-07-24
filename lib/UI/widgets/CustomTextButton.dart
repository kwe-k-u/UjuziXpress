import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  final String? foreText;
  @required final  String? actionText;
  @required final onPressed;

  CustomTextButton({
   this.foreText,
   this.onPressed,
   this.actionText
});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Material(
        color: Colors.transparent,
        shape: Border(
          bottom: BorderSide(color: Colors.deepPurple)
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: RichText(
            text: TextSpan(
                text: foreText,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                ),

                children: [

                  TextSpan(
                      text: actionText,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.deepPurple,
                      )
                  )
                ]
            ),
            strutStyle: StrutStyle(

            ),
          ),
        ),
      ),
      onTap: onPressed,
    );
  }
}
