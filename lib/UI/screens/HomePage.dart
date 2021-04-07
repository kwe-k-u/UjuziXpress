import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HistoryPage.dart';
import 'package:ujuzi_xpress/UI/screens/LoginPage.dart';
import 'package:ujuzi_xpress/UI/screens/ProfilePage.dart';
import 'package:ujuzi_xpress/UI/screens/RequestDeliveryPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/MapUi.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';


class HomePage extends StatefulWidget {
  @required final UjuziUser user;
  HomePage({this.user});


  @override
  _HomePageState createState() => _HomePageState();
}

//todo check permission requests
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    assert(widget.user != null); //ensure that the user is signed in

    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> ProfilePage(user: widget.user,)))
              ;
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.network(
                    widget.user.profileImageUrl,

                ),
              ),
            ),
          ),
        ]
      ),

      drawer: Drawer(

        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(left:8.0, right: 8.0, top:12.0),
              child: ClipOval(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                    widget.user.profileImageUrl,
                ),
              ),
            ),


            Text("Welcome ${widget.user.username}"),


            ListTile(
              title: Text("Profile"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ProfilePage(user: widget.user))
                );
              },// repo
            ),

            ListTile(
              title: Text("View History"),//
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>HistoryPage(user: widget.user))
                );
              },// report problem
            ),

            ListTile(
              title: Text("Raise a claim"),//report problem
            ),

            ListTile(
              title: Text("Terms and Conditions"),
            ),

            OutlinedButton(

              child: Text("Sign out"),
                onPressed: (){
                FirebaseAuth.instance.signOut().then((value) {

                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) =>LoginPage()
                  ));
                });
            })
          ],
        ),
      ),

      body: Stack(
        children: [
          MapUi(),


          DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.25,
              builder: (context, controller){
                return Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12.0))
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [

                        CustomRoundedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=> RequestDeliveryPage(requestingUser: widget.user,)));
                            },

                            buttonColor: Colors.white,
                            elevation: 0,
                            heightPadding: MediaQuery.of(context).size.height * 0.02,
                            textColor: Colors.black,
                            widthFactor: 0.3,
                            text: "create order".toUpperCase()
                        ),

                        Container(
                          margin: EdgeInsets.only(top:12.0),
                          child: CustomRoundedButton(
                              onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> HistoryPage(user: widget.user,)));
                              },

                              buttonColor: Colors.white,
                              widthFactor: 0.33,
                              elevation: 0,
                              heightPadding: MediaQuery.of(context).size.height * 0.02,
                              textColor: Colors.black,
                              text: "view order".toUpperCase()
                          ),
                        ),


                      ],
                    ),
            ),
                );
          })
        ],
      ),


    );
  }
}
