import 'package:flutter/material.dart';

abstract class SignUpEvent{
  BuildContext context;

  SignUpEvent(this.context);

}


class EmailSignUpEvent extends SignUpEvent{
  String email;
  String password;
  String username;
  String phoneNumber;

  EmailSignUpEvent(BuildContext context, this.email, this.password, this.username, this.phoneNumber) : super(context);
}




class GoogleSignUpEvent extends SignUpEvent{

  GoogleSignUpEvent(BuildContext context) : super(context);

}