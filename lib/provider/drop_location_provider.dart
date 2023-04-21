import 'package:flutter/material.dart';

import '../view/pages/home/create_job/creat_job.dart';

class DropOffLocationProvider extends ChangeNotifier {
  PickupLocation? pickupLocation;
  String? pickUpLocationData;

  setAddress({PickupLocation? pickupLocation, String? pickupLocationData}) {
    this.pickupLocation = pickupLocation;
    pickUpLocationData = "${pickupLocation?.address}"
        "${pickupLocation?.addressTwo}"
        "${pickupLocation?.city}"
        "${pickupLocation?.zipCode}"
        "${pickupLocation?.country}";
    notifyListeners();
  }
}
