import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';
import 'package:ujuzi_xpress/UI/widgets/BackgroundWidget.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomImageButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/signup/sign_up_bloc.dart';
import 'package:ujuzi_xpress/utils/bloc/authentication/signup/sign_up_event.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  AppResources resources = AppResources();
  final formKey = GlobalKey<FormState>();
  SignUpBloc _signUpBloc = new SignUpBloc();

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    numberController.clear();
    _signUpBloc.createInstance();
  }
  
  @override
  void dispose(){
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    numberController.dispose();
    _signUpBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        body: SingleChildScrollView(
          child: BackgroundWidget(
            child: Container(
              padding: EdgeInsets.only(
                  left: 20.0,
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
                    Spacer(
                      flex: 1,
                    ),

                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).sign_up.toUpperCase(),
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
                      AppLocalizations.of(context).signinwith.toUpperCase(),
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

                            _signUpBloc.signUpEventSink.add(GoogleSignUpEvent(context));
                            

                          },
                        ),
                        CustomImageButton(
                          path: "assets/facebook_logo.png",
                          onPressed: () {
                            resources.showSnackBar(
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
                            resources.showSnackBar(
                                actionLabel: "",
                                context: context,
                                content:
                                    "Awaiting Twitter approval for implementation");
                          },
                        ),
                      ],
                    ),

                    CustomTextField(
                      label: AppLocalizations.of(context).username,
                      inputType: TextInputType.name,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty)

                          return AppLocalizations.of(context).required_field;
                        else if (value.trim().length <= 2)
                          return AppLocalizations.of(context).name_longer_than_two_characters;
                      },
                    ),

                    //Email
                    CustomTextField(
                      label: AppLocalizations.of(context).email,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context).required_field;
                        else if ( (!value.contains("@") && !value.contains(".com")) ||(value.length <= 8))
                          return AppLocalizations.of(context).valid_email;
                      },
                    ),

                    //Password
                    CustomTextField(
                      label: AppLocalizations.of(context).password,
                      obscureText: true,
                      controller: passwordController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context).required_field;

                        else if (value.trim().length <= 8)
                          return AppLocalizations.of(context).name_longer_than_eight_characters;
                      },
                    ),

                    //number
                    CustomTextField(
                      label: AppLocalizations.of(context).phoneNumber,
                      inputType: TextInputType.phone,
                      controller: numberController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return AppLocalizations.of(context).required_field;
                        else if (value.length <= 9)
                          return AppLocalizations.of(context).valid_phone_number;
                      },
                    ),

                    Spacer(
                      flex: 1,
                    ),

                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextButton(
                          actionText: AppLocalizations.of(context).login,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          },
                        )),

                    Padding(
                      padding: const EdgeInsets.only(
                          right: 8.0, top: 12.0, bottom: 16.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomIconButton(
                          color: Colors.purple,
                          loadStream: _signUpBloc.signUpButtonStateStream,
                          onPressed: () async {

                            if(formKey.currentState.validate()) {

                              _signUpBloc.signUpEventSink.add(
                                  EmailSignUpEvent(context,emailController.text, passwordController.text, nameController.text, numberController.text)
                              );

                            }else{
                              resources.showSnackBar(context: context, content: AppLocalizations.of(context).requirements_not_met);
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
