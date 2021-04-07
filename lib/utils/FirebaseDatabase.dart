import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ujuzi_xpress/utils/DeliveryLocation.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';




FirebaseFirestore firestore = FirebaseFirestore.instance;


///Adds a delivery request to the user's account
Future<void> requestDelivery(DeliveryRequest request){
  CollectionReference reference = firestore.collection("users").doc(request.requestingUser.id).collection("deliveryRequest");
  return reference.add(request.asMap());

}

///Updates the user's default delivery location
DocumentReference postUserDetails({UjuziUser user, DeliveryLocation location}){
  CollectionReference reference = firestore.collection("users").doc(user.id).collection("profile");
  DocumentReference doc = reference.doc("info");
  doc.set(location.asMap());
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
  DocumentReference reference = firestore.collection('users').doc(id).collection("profile").doc("info");
  return reference.get();
}



Future<DocumentSnapshot> getUserCreditCard(String id){
  DocumentReference reference = firestore.collection('users').doc(id).collection("profile").doc("creditCard");
  return reference.get();
}




Future<List<DeliveryRequest>> getDeliveries(UjuziUser user) async {
  CollectionReference reference = firestore.collection('users').doc(user.id).collection('deliveryRequest');

  List<DeliveryRequest> requests = [];
  QuerySnapshot snapshot = await reference.orderBy("status").get();

  snapshot.docs.forEach((element) {
    DeliveryRequest delivery = deliveryRequestFromMap(element.data());
    delivery.setReference(element.reference);

    requests.add(delivery);
  });
  return requests;



}


