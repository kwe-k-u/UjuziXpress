import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/screens/DeliveryReceiptTextOnlyPage.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomLoadingIndicator.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/UI/widgets/DeliveryStatusTile.dart';
import 'package:ujuzi_xpress/UI/widgets/profile_image.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRider.dart';
import 'package:ujuzi_xpress/utils/models/Directions.dart';
import 'package:ujuzi_xpress/utils/services/FirebaseDatabase.dart';
import 'package:ujuzi_xpress/utils/services/LocationHandler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
import 'package:url_launcher/url_launcher.dart';


class DeliveryReceiptWithMapPage extends StatefulWidget {



  @override
  _DeliveryReceiptWithMapPageState createState() => _DeliveryReceiptWithMapPageState();
  @required final DeliveryRequest deliveryRequest;

  DeliveryReceiptWithMapPage({this.deliveryRequest});
}

class _DeliveryReceiptWithMapPageState extends State<DeliveryReceiptWithMapPage> {
CameraPosition initialPosition;
List<Marker> markers = [];
Directions directions;
GoogleMapController _googleMapController;
AppResources resources = new AppResources();
Rider assignedRider;







  @override
  void initState() {
    super.initState();



    initialPosition =  CameraPosition(
        target: widget.deliveryRequest.pickupLocation.location,
        zoom: 14
        );




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
    if (markers.isEmpty){

      markers.add(new Marker(
          markerId: MarkerId(AppLocalizations.of(context).pickup_location),
          position: widget.deliveryRequest.pickupLocation.location,
          icon: BitmapDescriptor.defaultMarkerWithHue(120),
          infoWindow: InfoWindow(title: "pickup")
      ));


      markers.add(new Marker(
          markerId: MarkerId(AppLocalizations.of(context).dropoff_location),
          position: widget.deliveryRequest.dropOffLocation.location
      ));
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(


      body: FutureBuilder(
        future: getAssignedRider(widget.deliveryRequest.deliveryID),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            assignedRider = snapshot.data;

            return Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: initialPosition,
                  onMapCreated: (controller) =>
                  _googleMapController = controller,
                  markers: markers.toSet(),
                  polylines: {
                    if (directions != null)
                      Polyline(
                        polylineId: const PolylineId('overview_polyline'),
                        color: Colors.red,
                        width: 5,
                        points: directions.polylinePoints
                            .map((e) {
                          return LatLng(e.latitude, e.longitude);
                        })
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
                        '${directions.totalDistance}, ${directions
                            .totalDuration}',
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
                    builder: (context, controller) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius
                                .circular(16.0))
                        ),
                        child: SingleChildScrollView(
                          controller: controller,
                          child: Column(
                            children: [


                              Container(
                                decoration: BoxDecoration(
                                    color: resources.primaryColour,
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.0))
                                ),
                                height: size.height * 0.1,
                                width: size.width,
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16.0))
                                    ),
                                    width: size.width * 0.6,
                                    height: size.height * 0.01,
                                  ),
                                ),
                              ),

                              DeliveryStatusTile(
                                status: widget.deliveryRequest.status,
                              ),

                              ListTile(
                                leading: ProfileImage(url: assignedRider.imageUrl,),
                                title: Text(assignedRider.name),
                                subtitle: Text(assignedRider.phoneNumber),
                                trailing: OutlinedButton.icon(
                                    onPressed: () {
                                      launch(
                                          "tel://${assignedRider.phoneNumber}");
                                    },
                                    icon: Icon(Icons.call), label: Text("")),
                              ),

                              CustomRoundedButton(
                                text: AppLocalizations
                                    .of(context)
                                    .view_package_information,
                                textColor: Colors.white,
                                elevation: 0,
                                widthFactor: 0.25,
                                heightPadding: 15.0,
                                buttonColor: Colors.black,
                                onPressed: () {
                                  Navigator.push(
                                      context, MaterialPageRoute(
                                      builder: (context) =>
                                          DeliveryReceiptWithTextOnlyPage(
                                            deliveryRequest: widget
                                                .deliveryRequest,)
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
            );
          }

          return Center(
            child: CustomLoadingIndicator(),
          );
        },
      ) ,
    );
  }
}

