import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';
import 'package:ujuzi_xpress/UI/widgets/BackgroundWidget.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomImageButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/Auth.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';
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

  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    nameController.clear();
    numberController.clear();
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
                          AppLocalizations.of(context).signin.toUpperCase(),
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
                            signInWithGoogle().then((value) {
                              // if (value.additionalUserInfo.isNewUser)
                              //   Navigator.pushReplacement(context, MaterialPageRoute(
                              //       builder: (context)=> ProfilePage(user: new UjuziUser(credential: value),)
                              //   ));

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            user: new UjuziUser(user: value),
                                          )));
                            });
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
                        print('value');
                      },
                    ),

                    //Email
                    CustomTextField(
                      label: AppLocalizations.of(context).email,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                    ),

                    //Password
                    CustomTextField(
                      label: AppLocalizations.of(context).password,
                      obscureText: true,
                      controller: passwordController,
                    ),

                    //number
                    CustomTextField(
                      label: AppLocalizations.of(context).signin,
                      inputType: TextInputType.phone,
                      controller: numberController,
                    ),

                    Spacer(
                      flex: 1,
                    ),

                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextButton(
                          actionText: AppLocalizations.of(context).localeName,
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
                          onPressed: () async {
                            //todo check password length and show snack if its not long enough

                            signUpWithEmail(emailController.text,
                                    passwordController.text)
                                .then((value) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                            user: new UjuziUser(
                                                user: value,
                                                name: nameController.text,
                                                number: numberController.text),
                                          )));
                            });
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
