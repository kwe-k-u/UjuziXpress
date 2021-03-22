import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HistoryPage.dart';
import 'package:ujuzi_xpress/UI/screens/RequestDeliveryPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/MapUi.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: Icon(Icons.account_circle_rounded),
            ),
          ),
        ]
      ),

      drawer: Drawer(
        child: Column(
          children: [

            ListTile(
              title: Text("Profile"),
            ),

            ListTile(
              title: Text("View History"),//
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HistoryPage()));
              },// report problem
            ),

            ListTile(
              title: Text("Raise a claim"),//report problem
            ),

            ListTile(
              title: Text("Sign out"),
            ),
          ],
        ),
      ),

      body: Stack(
        children: [
          MapUi(),


          DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.2,
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
                            onPressed: (){},
                            buttonColor: Colors.white,
                            textColor: Colors.black,
                            text: "create order".toUpperCase()
                        ),

                        CustomRoundedButton(
                            onPressed: (){},
                            buttonColor: Colors.white,
                            textColor: Colors.black,
                            text: "update order".toUpperCase()
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
