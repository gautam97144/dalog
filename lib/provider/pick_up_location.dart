import 'package:dalog_distribution/view/pages/home/create_job/creat_job.dart';
import 'package:flutter/foundation.dart';

class LocationProvider extends ChangeNotifier {
  PickupLocation? pickupLocation;
  String? pickUpLocationData;

  setAddress({PickupLocation? pickupLocation, String? pickupLocationData}) {
    this.pickupLocation = pickupLocation;
    pickUpLocationData = "${pickupLocation?.address}"
        " "
        "${pickupLocation?.addressTwo}"
        " "
        "${pickupLocation?.city}"
        ""
        "${pickupLocation?.zipCode}"
        ""
        "${pickupLocation?.country}";
    notifyListeners();
  }
}
