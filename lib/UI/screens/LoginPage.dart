import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/SignupPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(12.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              children: [
                Text("LOGIN IN")
              ],
            ),

            Text("Connect with"),

            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.face), label: Text("")),
                OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.face), label: Text("")),
                OutlinedButton.icon(onPressed: (){}, icon: Icon(Icons.face), label: Text("")),
              ],
            ),

            //Email
            CustomTextField(
              label: "Email",
            ),

            //Password
            CustomTextField(
              label: "Password",
              obscureText: true,
            ),


            CustomTextButton(
              actionText: "Don't have an account yet? Sign up",
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> SignupPage())
                );
              },
            ),


            Padding(
              padding: const EdgeInsets.only(right:8.0, top: 12.0),
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
    );
  }
}
