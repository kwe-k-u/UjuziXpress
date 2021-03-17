import 'package:flutter/material.dart';


class DeliveryListTile extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.black, )
      ),
      child: Column(
        children: [
          ListTile(
            title: Text("Order No: 201"),
            subtitle: Text("order date: 28/02/2020"),
          ),

          Divider(thickness: 3.0,
          indent: 12.0,
          endIndent: 12.0,
          ),

          Row(
            children: [
              Icon(Icons.send),
              Text("From: Billy's house"),
            ],
          ),

          Row(
            children: [
              Icon(Icons.location_on),
              Text("From: Airport hills"),
            ],
          ),
        ],
      ),
    );
  }
}
