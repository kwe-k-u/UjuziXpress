import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryListTile.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';



class HistoryPage extends StatefulWidget {
  @required UjuziUser user;
  HistoryPage({this.user});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // DeliveryStatus __status = DeliveryStatus.pending;
  List<bool> selectedArray = [true, false, false];





  ButtonStyle selectedStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),

  );
  // ButtonStyle deSelectedStyle = ButtonStyle();


  TextStyle selectedText = TextStyle(color: Colors.white);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        centerTitle: true,
      ),


      body: Container(
        child: FutureBuilder(
          future: getDeliveries(widget.user),
          builder: (context, snapshot){

            if (snapshot.connectionState == ConnectionState.done){
              return Column(
                children: [


                  Container(
                    margin: EdgeInsets.only(top: 8.0),
                    height: MediaQuery.of(context).size.height *0.05,
                    child: ToggleButtons(
                      borderWidth: 1.5,
                      isSelected: selectedArray,
                      color: Colors.black,
                      borderColor: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      fillColor: Colors.deepPurple,
                      onPressed: (index){
                        setState(() {
                          selectedArray = [false, false, false];
                          selectedArray[index] = true;
                        });
                      },
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text("Pending",

                            textAlign: TextAlign.center,
                            style: selectedArray.elementAt(0) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child:  Text("completed",
                            textAlign: TextAlign.center,
                            style: selectedArray.elementAt(1) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text("Canceled",
                            textAlign: TextAlign.center,
                            style: selectedArray.elementAt(2) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index){
                          return DeliveryListTile(
                            deliveryRequest: snapshot.data.elementAt(index),
                          );
                        }),
                  )
                ],
              );}


            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
