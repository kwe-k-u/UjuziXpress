import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/Auth.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/login/login_event.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/login/login_state.dart';
import 'package:ujuzi_xpress/utils/resources.dart';


class LoginBloc {
  final StreamController<LoginEvent> _loginEventStreamController =
  StreamController<LoginEvent>.broadcast();
  final StreamController<LoginState> _loginStateStreamController =
  StreamController<LoginState>.broadcast();
  final _loadingButtonStreamController = StreamController<ButtonState>();

  StreamSink<LoginEvent> get loginEventSink => _loginEventStreamController.sink;
  StreamSink<LoginState> get _loginStateSink =>
      _loginStateStreamController.sink;
  Stream<LoginState> get _loginStateStream => _loginStateStreamController.stream;
  Stream<ButtonState> get loginButtonStateStream =>
      _loadingButtonStreamController.stream;

  BuildContext _context;
  AppResources _appResources = AppResources();

  createInstance() {
    _loginEventStreamController.stream.listen(_mapLoginEventToState);
    _loginStateStream.listen(_loginStateHandler);
  }

  _mapLoginEventToState(LoginEvent _loginEvent) async {
    _context = _loginEvent.context;
    _loadingButtonStreamController.sink.add(ButtonState.loading);

    //authenticating based on login route of user
    switch(_loginEvent.runtimeType) {

      case EmailLoginEvent:
        //signing in with password and email
        EmailLoginEvent loginEvent = _loginEvent;

        if ((loginEvent.username == null || loginEvent.username.isEmpty) &&
            (loginEvent.password == null || loginEvent.password.isEmpty)) {
          _loginStateSink.add(LoginError('Username and Password fields are empty'));
        } else if (loginEvent.username == null || loginEvent.username.isEmpty) {
          _loginStateSink.add(LoginError('Email field is empty'));

        } else if (loginEvent.password == null || loginEvent.password.isEmpty) {
          _loginStateSink.add(LoginError('Password field is empty'));

        } else if (loginEvent.username.isNotEmpty &&
            loginEvent.password.isNotEmpty) {
          loginWithEmail(
              loginEvent.username, loginEvent.password).then(
                  (value) {
                    if (value == null) {
                      _loginStateSink.add(LoginError("Error with login"));


                    } else {//successful login
                      UjuziUser user = new UjuziUser(user: value);
                      _loginStateSink.add(LoginAuthenticated(user));
                    }
                  });
        }
        break;

        case GoogleLoginEvent:
          signInWithGoogle().then((value){
            if (value != null) {
              UjuziUser user = new UjuziUser(user: value);
              _loginStateSink.add(LoginAuthenticated(user));

            } else{
              _loginStateSink.add(LoginError('Error authenticating with Google. Retry in a couple minutes'));
            }
          });
          break;


      case TwitterLoginEvent:
        signInWithTwitter().then((value){
          if (value != null) {
            UjuziUser user = new UjuziUser(user: value);
            _loginStateSink.add(LoginAuthenticated(user));

          } else{
            _loginStateSink.add(LoginError('Error authenticating with Twitter. Retry in a couple minutes'));
          }
        });
        break;


          default:
            //unauthorized route
          _loginStateSink.add(LoginError("Unrecognised login process"));
    }
  }

  void _loginStateHandler(LoginState _loginState) {
    _loadingButtonStreamController.sink.add(ButtonState.normal);

    if (_loginState is LoginAuthenticated) {

         Navigator.pushReplacement(_context, MaterialPageRoute(
            builder: (_context)=> HomePage(user: _loginState.user,)
        ));

    } else if (_loginState is LoginError) {
      _appResources.showAlertDialog(_loginState.message, _context);
    }
  }

  void dispose() {
    _loginStateStreamController.close();
    _loginEventStreamController.close();
    _loadingButtonStreamController.close();
  }









  Future<User> loginWithEmail(String username, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password
      );
      return userCredential.user;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _appResources.showAlertDialog('No user found for that email.', _context);

      } else if (e.code == 'wrong-password') {
        _appResources.showAlertDialog('Wrong password provided for that user.', _context);

      } else{
        _appResources.showAlertDialog(e.code, _context);

      }
    }


    return null;
  }
}

