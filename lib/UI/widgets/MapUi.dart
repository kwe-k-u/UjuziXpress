import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapUi extends StatefulWidget {
  // final Function(LatLng cordinate) onTap;

  // MapUi({this.onTap});



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
        initialCameraPosition: position,
        markers: markers.toSet(),
        onMapCreated: (controler){
          setState(() {
            _controller = controler;
          });
        },

        onTap: (cordinates){
          _controller.animateCamera(CameraUpdate.newLatLng(cordinates));
          setState(() {
            markers.add(new Marker(markerId: MarkerId('current location'), position: cordinates));

          });

        },

      ),
    );
  }
}
