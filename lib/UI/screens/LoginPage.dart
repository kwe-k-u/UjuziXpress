import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/SignupPage.dart';
import 'package:ujuzi_xpress/UI/widgets/BackgroundWidget.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomImageButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    Text("LOGIN IN")
                  ],
                ),

                Spacer(flex: 1,),

                Center(child: Text("Connect with",)),

                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomImageButton(
                      path: "assets/google_logo.png",
                      onPressed: (){

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
                ),

                //Password
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: CustomTextField(
                    label: "Password",
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
