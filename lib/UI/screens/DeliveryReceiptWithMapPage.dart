import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/screens/DeliveryReceiptTextOnlyPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryStatusTile.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/Directions.dart';
import 'package:ujuzi_xpress/utils/LocationHandler.dart';


class DeliveryReceiptWithMapPage extends StatefulWidget {
  @required final DeliveryRequest deliveryRequest;

DeliveryReceiptWithMapPage({this.deliveryRequest});



  @override
  _DeliveryReceiptWithMapPageState createState() => _DeliveryReceiptWithMapPageState();
}

class _DeliveryReceiptWithMapPageState extends State<DeliveryReceiptWithMapPage> {
CameraPosition initialPosition;
List<Marker> markers = [];
Directions directions;
GoogleMapController _googleMapController;








  @override
  void initState() {
    super.initState();
    initialPosition =  CameraPosition(
        target: widget.deliveryRequest.pickupLocation.location,
        );

    markers.add(new Marker(
        markerId: MarkerId('pickup location'),
        position: widget.deliveryRequest.pickupLocation.location,
        icon: BitmapDescriptor.defaultMarkerWithHue(120),
      infoWindow: InfoWindow(title: "pickup")
    ));


    markers.add(new Marker(
        markerId: MarkerId('dropOff location'),
        position: widget.deliveryRequest.dropOffLocation.location
    ));

    getDirections(widget.deliveryRequest.pickupLocation.location, widget.deliveryRequest.dropOffLocation.location)
    .then((value) {
      setState(() {
        directions = value;
      });
    });
    //todo add marker for rider position
  }








  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(


      body: Stack(
        children: [
          // GoogleMap(
          //   cameraTargetBounds: directions != null ? CameraTargetBounds(directions.bounds): null,
          //   polylines: {
          //     new Polyline(
          //       polylineId: PolylineId('directions'),
          //       points: directions != null ? directions.polylinePoints.map((e) => LatLng(e.latitude, e.longitude)).toList() : null
          //     )
          //   },
          //   myLocationEnabled: true,
          //   zoomControlsEnabled: false,
          //   // trafficEnabled: true,
          //   initialCameraPosition: initialPosition,
          //   markers: markers.toSet(),
          // ),
          GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: initialPosition,
            onMapCreated: (controller) => _googleMapController = controller,
            markers: markers.toSet(),
            polylines: {
              if (directions != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: directions.polylinePoints
                      .map((e) {
                        return LatLng(e.latitude, e.longitude);})
                      .toList(),
                ),
            },
          ),
          if (directions != null)
            Positioned(
              top: 20.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${directions.totalDistance}, ${directions.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

          DraggableScrollableSheet(
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.3,
              builder: (context, controller){
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))
                  ),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [



                        Container(
                          decoration: BoxDecoration(
                              color: Colors.deepPurple,//todo darker
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))
                          ),
                          height: size.height * 0.1,
                          width: size.width,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all( Radius.circular(16.0))
                              ),
                              width: size.width * 0.6,
                              height: size.height *0.01,
                            ),
                          ),
                        ),

                        DeliveryStatusTile(
                          status: widget.deliveryRequest.status,
                        ),

                        ListTile(
                          leading: Icon(Icons.account_circle_rounded),
                          title: Text("Delivery Rider"),
                          subtitle: Text("+21336547898"),
                          trailing: OutlinedButton.icon(
                              onPressed: (){},
                              icon: Icon(Icons.call), label: Text("")),
                        ),

                        CustomRoundedButton(
                          text: "View Package Information",
                          textColor: Colors.white,
                          elevation: 0,
                          widthFactor: 0.25,
                          heightPadding: 15.0,
                          onPressed: (){
                            Navigator.push(
                                context, MaterialPageRoute(
                                builder: (context)=> DeliveryReceiptWithTextOnlyPage(deliveryRequest: widget.deliveryRequest,)
                            )
                            );
                          },
                        )
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

