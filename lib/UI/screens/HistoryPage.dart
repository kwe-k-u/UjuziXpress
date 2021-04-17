import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryListTile.dart';
import 'package:ujuzi_xpress/utils/DeliveryHistory.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class HistoryPage extends StatefulWidget {
  @required final UjuziUser user;
  HistoryPage({this.user});

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<bool> selectedArray = [true, false, false];
  int __index;
  List<DeliveryRequest> requests = [];
  DeliveryHistory history;




  ButtonStyle selectedStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),

  );


  TextStyle selectedText = TextStyle(color: Colors.white);




  void update(int index){

    setState(() {
      __index = index;
      selectedArray = [false, false, false];
      selectedArray[index] = true;

      switch(index){
        case 0:
          requests = history.pending;
          break;
        case 1:
          requests = history.completed;
          break;
        case 2:
          requests = history.canceled;
          break;
        default:
          requests = history.pending;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).my_orders),
        centerTitle: true,
      ),


      body: Container(
        child: FutureBuilder(
          future: getDeliveries(widget.user),
          builder: (context, snapshot){

            if (snapshot.connectionState == ConnectionState.done){
              history = new DeliveryHistory(snapshot.data);
              if (__index == null)  requests = history.pending;
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
                        update(index);
                      },

                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(AppLocalizations.of(context).pending,

                            textAlign: TextAlign.center,
                            style: selectedArray.elementAt(0) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                        ),


                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child:  Text(AppLocalizations.of(context).complete,
                            textAlign: TextAlign.center,
                            style: selectedArray.elementAt(1) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                        ),

                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Text(AppLocalizations.of(context).cancelled,
                            textAlign: TextAlign.center,
                            style: selectedArray.elementAt(2) ? selectedText : TextStyle(fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child:  requests.isNotEmpty ? ListView.builder(
                        itemCount: requests.length,
                        itemBuilder: (context,index){
                          return DeliveryListTile(
                            user: widget.user,
                            deliveryRequest: requests.elementAt(index),
                          );
                        })
                    : Center(child: Text(AppLocalizations.of(context).no_requests),),
                  )
                ],
              );
            }


            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
