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
    firebaseAuth.signOut().then((value) => super.setState(() {

    }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                    Text("LOGIN IN",
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
                    child: Text("Connect with",
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
                          UjuziUser user = new UjuziUser(credential: value);

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
                  label: "Email",
                  controller: emailController,
                ),

                //Password
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextField(
                    label: "Password",
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),



                Spacer(flex: 2,),
                Center(
                  child: CustomTextButton(
                    foreText: "Don't have an account yet?",
                    actionText:" Sign up",
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
    );
  }
}
