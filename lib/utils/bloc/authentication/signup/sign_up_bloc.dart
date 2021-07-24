
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/Auth.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/signup/sign_up_event.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/signup/sign_up_state.dart';
import 'package:ujuzi_xpress/utils/resources.dart';

class SignUpBloc {
  final StreamController<SignUpEvent> _signUpEventStreamController =
  StreamController<SignUpEvent>();
  final StreamController<SignUpState> _signUpStateStreamController =
  StreamController<SignUpState>();
  final _loadingButtonStreamController = StreamController<ButtonState>();

  StreamSink<SignUpEvent> get signUpEventSink =>
      _signUpEventStreamController.sink;
  StreamSink<SignUpState> get _signUpStateSink =>
      _signUpStateStreamController.sink;
  Stream<SignUpState> get _signUpStateStream =>
      _signUpStateStreamController.stream;
  Stream<ButtonState> get signUpButtonStateStream =>
      _loadingButtonStreamController.stream;

  late BuildContext _context;
  AppResources _appResources = AppResources();

  createInstance() {
    _signUpEventStreamController.stream.listen(_mapSignUpEventToState);
    _signUpStateStream.listen(_signUpStateHandler);
  }

  _mapSignUpEventToState(SignUpEvent signupEvent) async {
    _context = signupEvent.context;
    _loadingButtonStreamController.sink.add(ButtonState.loading);

    switch (signupEvent.runtimeType) {

      case EmailSignUpEvent:
        EmailSignUpEvent _signupEvent = signupEvent as EmailSignUpEvent;

        if (
            _signupEvent.email == null ||
            _signupEvent.email.isEmpty ||
            _signupEvent.username == null ||
            _signupEvent.username.isEmpty ||
            _signupEvent.password == null ||
            _signupEvent.password.isEmpty ||
            _signupEvent.phoneNumber == null ||
            _signupEvent.phoneNumber.isEmpty
        ) {
          _signUpStateSink.add(SignUpError('One or more fields are empty'));
        } else {

          User? value = await signUpWithEmail(_signupEvent.email, _signupEvent.password, _signupEvent.username, _signupEvent.phoneNumber);

          if(value == null){
            print("Error");
            _signUpStateSink.add(SignUpError("Error with sign up"));
          } else{
            print(" No error email signup");
            UjuziUser user = new UjuziUser(user:value);
            _signUpStateSink.add(SignUpAuthenticated(user));

          }

        }

        break;

        case GoogleSignUpEvent:

          signInWithGoogle().then((value){
            if (value != null) {
              UjuziUser user = new UjuziUser(user: value);
              _signUpStateSink.add(SignUpAuthenticated(user));

            } else{
              _signUpStateSink.add(SignUpError('Error authenticating with Google. Retry in a couple minutes'));
            }
          });
          break;


      default:
      //unauthorized route
        _signUpStateSink.add(SignUpError("Unrecognised signup process"));

    }


  }

  _signUpStateHandler(SignUpState _signUpState) {
    _loadingButtonStreamController.sink.add(ButtonState.normal);

    if (_signUpState is SignUpAuthenticated) {
      Navigator.pushReplacement(_context, MaterialPageRoute(
          builder: (context)=> HomePage(user: _signUpState.user,)
      ));


    } else if (_signUpState is SignUpError) {
      _appResources.showAlertDialog(_signUpState.message, _context);
    } else{
      Navigator.pushReplacement(_context, MaterialPageRoute(
          builder: (context)=> HomePage(user: _signUpState.user,)
      ));
    }
  }


  void dispose() {
    _signUpEventStreamController.close();
    _signUpStateStreamController.close();
    _loadingButtonStreamController.close();
  }
}