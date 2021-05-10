import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/models/DeliveryRider.dart';
import 'package:ujuzi_xpress/utils/models/UjuziUser.dart';
import 'package:http/http.dart' as http;




FirebaseFirestore firestore = FirebaseFirestore.instance;


///Adds a delivery request to the user's account
/// If the request is new, a new firebase reference is given, else existing reference is updated
Future<void> requestDelivery(DeliveryRequest request){
  if (request.reference != null){
    return request.reference.update(request.asMap());

  } else {
    CollectionReference reference = firestore.collection("users").doc(
        request.requestingUser.id).collection("deliveryRequest");
    return reference.add(request.asMap());
  }

}

///Updates the user's default delivery location
DocumentReference postUserDetails({UjuziUser user}){
  CollectionReference reference = firestore.collection("users").doc(user.id).collection("profile");
  DocumentReference doc = reference.doc("info");
  doc.set(user.asMap());
  return doc;
}

///Updates the user's credit card info
DocumentReference postUserCreditCard({
  UjuziUser user,
  String cardNumber,
  String ccv,
  DateTime expiryDate,
  String holderName}) {



  CollectionReference reference = firestore.collection("users").doc(user.id).collection("profile");
  DocumentReference doc = reference.doc("creditCard");


  Map<String, dynamic> card = {
    'ccv' : ccv,
    'expiryDate' : expiryDate.toString(),
    'holderName' : holderName,
    'cardNumber' : cardNumber
  };

  doc.set(card);


  return doc;
}








//GETTERS

Future<DocumentSnapshot> getUserDetails(String id){

  try {
    DocumentReference reference = firestore.collection('users')
        .doc(id)
        .collection("profile")
        .doc("info");
    return reference.get();

  } catch (e){//if the document does not exist
    return null;
  }
}



Future<DocumentSnapshot> getUserCreditCard(String id){
  try {
  DocumentReference reference = firestore.collection('users').doc(id).collection("profile").doc("creditCard");
  return reference.get();

  } catch (e){//if the document does not exist
    return null;
  }
}




Future<List<DeliveryRequest>> getDeliveries(UjuziUser user) async {
  CollectionReference reference = firestore.collection('users').doc(user.id).collection('deliveryRequest');

  List<DeliveryRequest> requests = [];
  QuerySnapshot snapshot = await reference.orderBy("status", descending: true).get();

  snapshot.docs.forEach((element) {
    DeliveryRequest delivery = DeliveryRequest.fromMap(element.data());
    delivery.setReference(element.reference);

    requests.add(delivery);
  });
  return requests;



}




Future<void> uploadImage({UjuziUser user, File image}) async{
  FirebaseStorage storage = FirebaseStorage.instance;
  await storage.ref("${user.id}/profileImage").putFile(image);
  user.update(profileUrl: await storage.ref("${user.id}/profileImage").getDownloadURL());

}

Future<Rider> getAssignedRider(String id) async{
  Rider rider;


  var request = http.Request('GET', Uri.parse('https://us-central1-ujuzi-express.cloudfunctions.net/get_Assigned_Rider?deliveryId=56aYbxpnJH5e5gbM1EdI'));


  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    final request = await response.stream.bytesToString();
    final Map<String,dynamic> data = json.decode(request);

    String name;
    String profileImage;
    String number;

    if (data.containsKey("name"))
      name = data['name']['stringValue'];
    if (data.containsKey("phoneNumber"))
      number = data['phoneNumber']['stringValue'];
    if (data.containsKey("profileImage"))
      profileImage = data['profileImage']['stringValue'];
    rider = new Rider(name, number, profileImage);

  }


  return rider;
}


