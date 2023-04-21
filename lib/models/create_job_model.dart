import 'package:flutter/material.dart';

class CreateJob {
  String? jobTitle;
  String? pickupLocation;
  String? pickupDate;
  String? pickupTime;
  String? dropOffLocation;
  String? dropOffDate;
  String? dropOffTime;

  CreateJob(
      {this.jobTitle,
      this.pickupLocation,
      this.pickupDate,
      this.pickupTime,
      this.dropOffLocation,
      this.dropOffDate,
      this.dropOffTime});
}
