import 'package:flutter/material.dart';
import 'package:ujuzi_xpress/UI/widgets/CustomLoadingIndicator.dart';
import 'package:ujuzi_xpress/utils/services/LocationHandler.dart';
import 'package:ujuzi_xpress/utils/models/places_search.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart' as arg;


class LocationTextField extends StatefulWidget {

  final String label;
  final TextEditingController? controller;
  final bool obscureText;
  final Color color;
  final Color labelColor;
  final Color selectedColor;
  final double widthFactor;
  final String? value;
  final Function(String)? validator;
  final Function(String value)? onChanged;
  final Function onIconTap;
  final FocusNode focusNode;

  LocationTextField({
    required this.label,
    this.value,
    this.validator,
    this.controller,
    this.obscureText = false,
    this.color = Colors.white,
    this.selectedColor = Colors.pink,
    this.labelColor = Colors.white,
    this.widthFactor =0.7,
    this.onChanged,
    required this.focusNode,
    required this.onIconTap,


  });



  @override
  _LocationTextFieldState createState() => _LocationTextFieldState();
}

class _LocationTextFieldState extends State<LocationTextField> {
  List<PlaceSearch> places = [];
  bool showDropDown = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Theme(
      data: new ThemeData(
          primaryColor: widget.selectedColor
      ),
      child:  Container(
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        width: size.width * widget.widthFactor,
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 8,
                  child: Focus(
                    onFocusChange: (bool){
                      setState(() {
                        showDropDown = bool;
                      });
                    },
                    child: TextFormField(

                      validator: widget.validator as String? Function(String?)?,
                      obscureText: widget.obscureText,
                      controller: widget.controller,
                      keyboardType: TextInputType.text,
                      focusNode: widget.focusNode,
                      onChanged: (value) async{
                        if (value.isNotEmpty) {
                          getPlaceSuggestions(value, Localizations
                              .localeOf(context)
                              .languageCode).then((pl) {
                            setState(() {
                              places = pl;
                            });
                          });
                        } else {
                          setState(() {
                            places = [];
                          });
                        }
                      },
                      onTap: (){
                        // widget.focusNode.requestFocus();
                      },
                      decoration: InputDecoration(

                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: widget.color)
                          ),
                          labelText: widget.label ,
                          labelStyle: TextStyle(color: widget.labelColor),
                      ),
                    ),
                  ),
                ),

                arg.ArgonButton(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                  height: MediaQuery.of(context).size.width * 0.1,
                  roundLoadingShape: true,
                  width: MediaQuery.of(context).size.width * 0.1,
                  borderRadius: 5.0,
                  color: Colors.transparent,
                  elevation: 0,
                  child: Icon(Icons.my_location),

                  onTap: (startLoading, stopLoading, btnState) {
                    startLoading();

                    widget.onIconTap();

                    stopLoading();
                  },
                  loader: Container(
                    padding: EdgeInsets.all(10),
                    child:  CustomLoadingIndicator(),
                  ),
                )
              ],
            ),

            if (showDropDown && places.isNotEmpty)
              Card(
                elevation: 6.0,
                child: SizedBox(
                  height: size.height * 0.15,

                  child:  ListView.builder(
                      itemCount: places.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: (){
                            setState(() {
                              widget.controller!.text = places[index].name!;
                            });

                          },
                          subtitle: Divider(color: Colors.white, thickness: 2.0,),
                          title: Text(places[index].name!),
                          tileColor: Colors.grey.shade300,
                        );
                      }),
                ),
              )
          ],
        ),
      ),
    );
  }
}
