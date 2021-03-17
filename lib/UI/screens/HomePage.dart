import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/screens/HistoryPage.dart';
import 'package:ujuzi_xpress/UI/screens/RequestDeliveryPage.dart';
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

      body: Container(
        child: MapUi(),
      ),

      floatingActionButton: FloatingActionButton(
        child: Text("temp"),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> RequestDeliveryPage()));
        },
      ),
    );
  }
}
