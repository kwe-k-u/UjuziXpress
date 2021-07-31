import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomRoundedButton.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/resources.dart';
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [


            GoogleMap(
              mapToolbarEnabled: false,
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


            Align(
              alignment: Alignment.topCenter,
                child: _LocationTextWidget(location.locationName!)
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * 0.05),
                child: CustomRoundedButton(
                  text: AppLocalizations.of(context)!.select,
                  onPressed: (){
                    Navigator.pop(context, location);
                  },
                ),
              ),
            )




          ],
        ),
      ),
    );
  }
}








class _LocationTextWidget extends StatelessWidget {
  final String location;
  const _LocationTextWidget(this.location,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(12),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular( 36),
        color: AppResources().primaryColour.withAlpha(200)
      ),
      margin: EdgeInsets.only(top:size.height * 0.1),
      child: Text(location,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

