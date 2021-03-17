import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HomePage.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomIconButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextButton.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomTextField.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

            //Name
            CustomTextField(
              label: "Name",
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

            //number
            CustomTextField(
              label: "Phone number",
            ),


            Align(
              alignment: Alignment.centerLeft,
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
