import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/ProfilePage.dart';
import 'package:ujuzi_xpress/UI/screens/SignupPage.dart';
import 'package:ujuzi_xpress/UI/widgets/BackgroundWidget.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomImageButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';
import 'package:ujuzi_xpress/utils/Auth.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();



  @override
  void initState() {
    super.initState();
    emailController.clear();
    passwordController.clear();
    firebaseAuth.signOut();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: BackgroundWidget(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, top: size.height * 0.08, right: 8.0, bottom: size.height * 0.08),
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Text(AppLocalizations.of(context).login.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0
                        ),
                      )
                    ],
                  ),

                  Spacer(flex: 1,),

                  Center(
                      child: Text(AppLocalizations.of(context).connect_with,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ),
                      )
                  ),

                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomImageButton(
                        path: "assets/google_logo.png",
                        onPressed: (){
                          signInWithGoogle().then((value){

                            UjuziUser user = new UjuziUser(user: value);

                            if(user.number == null || user.email == null){
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context)=> ProfilePage(user: user,)
                              ));
                            }


                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context)=> HomePage(user: user,)
                            ));
                          });


                        },
                      ),

                      CustomImageButton(
                        path: "assets/facebook_logo.png",
                        onPressed: (){

                        },
                      ),

                      CustomImageButton(
                        path: "assets/twitter_logo.png",
                        widthFactor: 0.14,
                        onPressed: (){

                        },
                      ),
                    ],
                  ),

                  //Email
                  CustomTextField(
                    label: AppLocalizations.of(context).email,
                    controller: emailController,
                  ),

                  //Password
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CustomTextField(
                      label: AppLocalizations.of(context).password,
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ),



                  Spacer(flex: 2,),
                  Center(
                    child: CustomTextButton(
                      foreText: AppLocalizations.of(context).dont_have_an_account_yet,
                      actionText:AppLocalizations.of(context).sign_up,
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> SignupPage())
                        );
                      },
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(right:8.0, top: 12.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomIconButton(
                        color: Colors.purple,
                        onPressed: (){
                          //todo authenticate
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=> HomePage()
                          ));
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
    );
  }
}
