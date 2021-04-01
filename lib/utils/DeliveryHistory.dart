//data structure to contain the list of deliveries in a sorted lists
import 'package:ujuzi_xpress/utils/DeliveryRequest.dart';

class DeliveryHistory{
  List<DeliveryRequest> __pendingDeliveries;
  List<DeliveryRequest> __canceledDeliveries;
  List<DeliveryRequest> __completedDeliveries;


  List<DeliveryRequest> get pending=> __pendingDeliveries;
  List<DeliveryRequest> get canceled => __canceledDeliveries;
  List<DeliveryRequest> get completed => __completedDeliveries;


  //list of deliveries from firebase
  DeliveryHistory(Map<String, dynamic> map){
    __pendingDeliveries = [];
    __canceledDeliveries = [];
    __completedDeliveries = [];

    map.forEach((key, value) {
      DeliveryRequest request = deliveryRequestFromMap(value);


      switch(request.status){
        case DeliveryStatus.cancelled:
          __canceledDeliveries.add(request);
          break;

        case DeliveryStatus.complete:
          __completedDeliveries.add(request);
          break;

        default:
          __pendingDeliveries.add(request); //todo sort by grouping ongoing first, then pending before sorting each by date
      }
    });



  }


  void __sortPending(){}//method to sort the pending list by ongoing and pendinging and then by date







}