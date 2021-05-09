import 'package:flutter/material.dart';

abstract class LoginEvent  {
  BuildContext context;

  LoginEvent(this.context);
}


class EmailLoginEvent extends LoginEvent{
  String username;
  String password;

  EmailLoginEvent(BuildContext context, this.username, this.password) : super(context);

}


class GoogleLoginEvent extends LoginEvent{

  GoogleLoginEvent(BuildContext context) : super(context);
}


class FacebookLoginEvent extends LoginEvent{

  FacebookLoginEvent(BuildContext context) : super(context);
}


class TwitterLoginEvent extends LoginEvent{

  TwitterLoginEvent(BuildContext context) : super(context);
}




