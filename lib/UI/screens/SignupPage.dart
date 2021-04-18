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
                        if (value == null || value.isEmpty)
                          //todo add to localisations
                          return "This is a required field";
                        else if (value.trim().length <=2)
                          return "Name has to be longer than 2 characters";
                      },
                    ),

                    //Email
                    CustomTextField(
                      label: AppLocalizations.of(context).email,
                      inputType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return "This is a required field";
                        else if (!value.contains("@") && !value.contains(".com"))
                          return "enter a valid email address";
                        else if (value.length <= 8)
                          return 'Enter a valid email address';
                      },
                    ),

                    //Password
                    CustomTextField(
                      label: AppLocalizations.of(context).password,
                      obscureText: true,
                      controller: passwordController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return "This is a required field";

                        else if (value.trim().length <= 8)
                          return 'Password must have more than 8 characters';
                      },
                    ),

                    //number
                    CustomTextField(
                      label: AppLocalizations.of(context).phoneNumber,
                      inputType: TextInputType.phone,
                      controller: numberController,
                      validator: (value){
                        if (value == null || value.isEmpty)
                          return "This is a required field";
                        else if (value.length <= 9)
                          return 'Enter a valid phone number address';
                      },
                    ),

                    Spacer(
                      flex: 1,
                    ),

                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextButton(
                          actionText: AppLocalizations.of(context).sign_up,
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

                            if(formKey.currentState.validate()) {

                              signUpWithEmail(emailController.text,
                                  passwordController.text)
                                  .then((value) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomePage(
                                              user: new UjuziUser(
                                                  user: value,
                                                  name: nameController.text,
                                                  number: numberController
                                                      .text),
                                            )));
                              });


                            }else{
                              resources.showSnackBar(context: context, content: "Registration requirements not met");
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
