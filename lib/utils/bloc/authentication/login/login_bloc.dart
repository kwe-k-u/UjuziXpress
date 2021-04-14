import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/utils/Auth.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/login/login_event.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/login/login_state.dart';


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
  // AppResources _appResources = AppResources();

  createInstance() {
    _loginEventStreamController.stream.listen(_mapLoginEventToState);
    _loginStateStream.listen(_loginStateHandler);
  }

  _mapLoginEventToState(LoginEvent _loginEvent) async {
    _context = _loginEvent.context;
    _loadingButtonStreamController.sink.add(ButtonState.loading);

    //signing in with password and email
    if ((_loginEvent.username == null || _loginEvent.username.isEmpty) &&
        (_loginEvent.password == null || _loginEvent.password.isEmpty)) {

      _loginStateSink.add(LoginError('Username and Password fields are empty'));

    } else if (_loginEvent.username == null || _loginEvent.username.isEmpty) {
      _loginStateSink.add(LoginError('Username field is empty'));
      // TODO: change to email

    } else if (_loginEvent.password == null || _loginEvent.password.isEmpty) {
      _loginStateSink.add(LoginError('Password field is empty'));

    } else if (_loginEvent.username.isNotEmpty &&
        _loginEvent.password.isNotEmpty) {
      User _responseUser = await loginWithEmail(_loginEvent.username, _loginEvent.password);
      _loginStateSink.add(LoginAuthenticated( UjuziUser(user: _responseUser)));
      // await _login(_loginEvent.username, _loginEvent.password);


      // if (_response.statusCode == 201) {
      //   _loginStateSink.add(LoginAuthenticated(
      //       UjuziUser(user: )));
      // } else {
      //   //TODO: implement login error and print error message from response
      //   _loginStateSink.add(
      //       LoginError('from api ${jsonDecode(_response.body)['message']}'));
      // }
    // } else {
    //   _loginStateSink.add(LoginError('Re-enter username and password'));
    }
  }

  void _loginStateHandler(LoginState _loginState) {
    _loadingButtonStreamController.sink.add(ButtonState.normal);

    if (_loginState is LoginAuthenticated) {
      //TODO: pass _loginState.user to next page
      // _appResources.showAlertDialog('login successful',_context);
    } else if (_loginState is LoginError) {
      // _appResources.showAlertDialog(_loginState.message, _context);
    }
  }
  //
  // _login(String _username, String _password) async {
  //   return await http.post(
  //     Uri.https(
  //       'studaid-gateway.herokuapp.com',
  //       '/api/v1/auth/login',
  //     ),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       'username': _username,
  //       'password': _password,
  //     }),
  //   );
  // }

  void dispose() {
    _loginStateStreamController.close();
    _loginEventStreamController.close();
    _loadingButtonStreamController.close();
  }
}
