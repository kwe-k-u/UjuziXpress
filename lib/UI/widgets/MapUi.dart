import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ujuzi_xpress/utils/services/LocationHandler.dart';


class MapUi extends StatefulWidget {
final bool enabled;


  MapUi({this.enabled = false});


  @override
  _MapUiState createState() => _MapUiState();
}

class _MapUiState extends State<MapUi> {
  CameraPosition position = CameraPosition(target: LatLng(-22,401));
  GoogleMapController _controller ;
  List<Marker> markers = [];


  
  
  @override
  Widget build(BuildContext context) {

    return ClipRect(
      child: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: position,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: markers.toSet(),
        onMapCreated: (controler){
          setState(() {
            _controller = controler;
            determinePosition().then((value) {
              _controller.animateCamera(
                  CameraUpdate.newLatLngZoom(value.location,14.0));

            }).onError((error, stackTrace) {
              _controller.animateCamera(CameraUpdate.newCameraPosition(position));
            });
          });
        },

        onTap: (cordinates){

          setState(() {
            _controller.animateCamera(
                CameraUpdate.newLatLngZoom(cordinates,14.0));

          });

          if (widget.enabled) {
            _controller.animateCamera(CameraUpdate.newLatLng(cordinates));
            setState(() {
              markers.add(new Marker(markerId: MarkerId('current location'),
                  position: cordinates));
            });
          }

        },

      ),
    );
  }
}
