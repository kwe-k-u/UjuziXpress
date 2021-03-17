import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryListTile.dart';



class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
      ),


      body: Container(
        child: Column(
          children: [

            ButtonBar(
                children: [

              ElevatedButton(
                child: Text("Pending"),
                onPressed: (){

                },
              ),

              ElevatedButton(
                child: Text("completed"),
                onPressed: (){

                },
              ),

              ElevatedButton(
                child: Text("Canceled"),
                onPressed: (){

                },
              ),

            ]),

            Expanded(
              child: ListView.builder(
                itemCount: 2,
                  itemBuilder: (context,index){
                  return DeliveryListTile();
              }),
            )
          ],
        ),
      ),
    );
  }
}
