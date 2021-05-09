import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';


abstract class LoginState {
  UjuziUser user;
  String message;

  LoginState({this.user, this.message});
}

class LoginAuthenticated extends LoginState {
  UjuziUser user;
  LoginAuthenticated(this.user) : super(user: user);
}

class LoginUnauthenticated extends LoginState {}


class LoginError extends LoginState {
  String message;
  LoginError(this.message) : super(message: message);
}
