import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/SignupPage.dart';
import 'package:ujuzi_xpress/UI/widgets/BackgroundWidget.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomImageButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/login/login_bloc.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/login/login_event.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AppResources _resources = AppResources();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  LoginBloc _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();
    _loginBloc.createInstance();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _loginBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: BackgroundWidget(
            child: Container(
              padding: EdgeInsets.only(
                  left: 16.0,
                  top: size.height * 0.08,
                  right: 8.0,
                  bottom: size.height * 0.08),
              width: size.width,
              height: size.height,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).login.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0),
                        )
                      ],
                    ),

                    Spacer(
                      flex: 1,
                    ),

                    Center(
                        child: Text(
                      AppLocalizations.of(context).connect_with,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    )),

                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomImageButton(
                          path: "assets/google_logo.png",
                          onPressed: () {

                            _loginBloc.loginEventSink.add(GoogleLoginEvent(context));

                          },
                        ),


                        CustomImageButton(
                          path: "assets/facebook_logo.png",
                          onPressed: () async {
                            _resources.showSnackBar(
                                actionLabel: "",
                                context: context,
                                content:
                                    "Awaiting Facebook approval for implementation");
                          },
                        ),


                        CustomImageButton(
                          path: "assets/twitter_logo.png",
                          widthFactor: 0.14,
                          onPressed: () {
                            _resources.showSnackBar(
                                actionLabel: "",
                                context: context,
                                content:
                                    "Awaiting Twitter approval for implementation");
                          },
                        ),
                      ],
                    ),

                    //Email
                    CustomTextField(
                      label: AppLocalizations.of(context).email,
                      controller: emailController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return 'This field cannot be empty';
                      },
                    ),

                    //Password
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: CustomTextField(
                        label: AppLocalizations.of(context).password,
                        controller: passwordController,
                        obscureText: true,
                        validator: (value){
                          if (value == null || value.isEmpty)
                            return 'This field cannot be empty';
                        },
                      ),
                    ),

                    Spacer(
                      flex: 2,
                    ),


                    Center(
                      child: CustomTextButton(
                        foreText:
                            AppLocalizations.of(context).dont_have_an_account_yet,
                        actionText: AppLocalizations.of(context).sign_up,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                      ),
                    ),



                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 12.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: CustomIconButton(
                          color: Colors.purple,
                          loadStream: _loginBloc.loginButtonStateStream,
                          onPressed: () {

                            if (formKey.currentState.validate()){
                              _loginBloc.loginEventSink.add(EmailLoginEvent(context,emailController.text, passwordController.text));

                            }
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
