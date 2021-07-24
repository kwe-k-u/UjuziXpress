import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/services/LocationHandler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class PickLocationPage extends StatefulWidget {
  @override
  _PickLocationPageState createState() => _PickLocationPageState();
}

class _PickLocationPageState extends State<PickLocationPage> {
  CameraPosition position = CameraPosition(target: LatLng(-22,401));
  late GoogleMapController _controller ;
  List<Marker> markers = [];
  DeliveryLocation location = new DeliveryLocation(name: "");



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [


            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: GoogleMap(
                myLocationEnabled: true,
                initialCameraPosition: position,
                markers: markers.toSet(),
                onMapCreated: (controler){

                  setState(() {
                    _controller = controler;
                    determinePosition().then((value) {
                      _controller.animateCamera(
                          CameraUpdate.newLatLngZoom(value.location!,14.0));

                    });
                  });
                },

                onTap: (cordinates){
                  _controller.animateCamera(CameraUpdate.newLatLng(cordinates));


                  getAddressFromLatLng(cordinates).then((value) {
                            setState(() {
                              location = new DeliveryLocation(name: value, lat: cordinates);
                              markers.add(new Marker(markerId: MarkerId("location"), position: cordinates));
                            });

                          });



                },

              ),
            ),


            Text(location.locationName!),

            CustomRoundedButton(
              text: AppLocalizations.of(context)!.select,
              onPressed: (){
                Navigator.pop(context, location);
              },
            )




          ],
        ),
      ),
    );
  }
}
