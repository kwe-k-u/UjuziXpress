

import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';

abstract class SignUpState {
  UjuziUser? user;
  String? message;

  SignUpState({this.user, this.message});
}

class SignUpAuthenticated extends SignUpState {
  UjuziUser? user;
  SignUpAuthenticated(this.user) : super(user: user);
}

class SignUpUnauthenticated extends SignUpState {}

class SignUpError extends SignUpState {
  String? message;
  SignUpError(this.message) : super(message: message);
}
