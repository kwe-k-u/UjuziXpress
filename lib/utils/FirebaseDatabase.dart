import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';
import 'package:ujuzi_xpress/utils/UjuziUser.dart';




FirebaseFirestore firestore = FirebaseFirestore.instance;



Future<void> requestDelivery(DeliveryRequest request){
  CollectionReference reference = firestore.collection("users").doc(request.requestingUser.id).collection("deliveryRequest");
  return reference.add(request.asMap());

}

Future<DocumentReference> postUserDetails(UjuziUser user){
  CollectionReference reference = firestore.collection("users").doc(user.id).collection("profile");
  return reference.add(user.asMap());
}








//GETTERS

Future<DocumentSnapshot> getUserDetails(String id){
  DocumentReference reference = firestore.collection('users').doc(id).collection("profile").doc();
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