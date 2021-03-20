import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomImageButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      backgroundColor: Colors.white70,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 20.0, top: size.height * 0.08, right: 8.0, bottom: size.height * 0.08),
          width: size.width,
          height: size.height,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Spacer(flex: 1,),

              Row(
                children: [
                  Text("SIGN UP")
                ],
              ),


              Spacer(flex: 1,),
              Center(child: Text("SIGN UP WITH", )),

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

              //Name
              CustomTextField(
                label: "Name",
                inputType: TextInputType.name,
              ),

              //Email
              CustomTextField(
                label: "Email",
                inputType: TextInputType.emailAddress,
              ),

              //Password
              CustomTextField(
                label: "Password",
                obscureText: true,
              ),

              //number
              CustomTextField(
                label: "Phone number",
                inputType: TextInputType.phone,
              ),


              Spacer(flex: 1,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextButton(
                  actionText: "Login",
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> LoginPage())
                    );
                  },
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(right:8.0, top: 12.0, bottom: 16.0),
                child: Align(
                  alignment: Alignment.centerRight,
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
    );
  }
}
