import 'package:flutter/cupertino.dart';

class OtpArguments {
  String? id;
  String? otp;
  int? status;

  OtpArguments({this.id, this.otp, this.status});
}

class CreateJobModel {
  String? jobTitle;
  String? pickUpLocation;
  String? pickUpDate;
  String? pickUpTime;
  String? dropOffLocation;
  String? dropOffDate;
  String? dropOffTime;
  String? pickUpAddress;
  String? pickUpAddressTwo;
  String? pickupCity;
  String? pickUpState;
  String? pickUpZipCode;
  String? pickUpcountry;
  String? dropOffAddress;
  String? dropOffAddressTwo;
  String? dropOffCity;
  String? dropOffState;
  String? dropOffZipCode;
  String? dropOffCountry;
  String? instruction;

  CreateJobModel(
      {this.jobTitle,
      this.pickUpLocation,
      this.pickUpDate,
      this.pickUpTime,
      this.dropOffLocation,
      this.dropOffDate,
      this.dropOffTime,
      this.pickUpAddress,
      this.pickUpAddressTwo,
      this.pickupCity,
      this.pickUpState,
      this.pickUpZipCode,
      this.pickUpcountry,
      this.dropOffAddress,
      this.dropOffAddressTwo,
      this.dropOffCity,
      this.dropOffState,
      this.instruction,
      this.dropOffZipCode,
      this.dropOffCountry});
}

class CreateJobSecondModel {
  String? totalValue;
  String? estimateCost;
  String? serviceFees;
  String? itemName;
  CreateJobModel? createJobModel;
  String? image;
  String? quantity;
  String? length;
  String? width;
  String? weight;
  String? height;
  List<Map<String,dynamic>>? customizeItem;


  CreateJobSecondModel(
      {this.totalValue,
      this.itemName,
      this.estimateCost,
      this.serviceFees,
      this.createJobModel,
      this.length,
      this.quantity,
      this.weight,
      this.width,
      this.height,
        this.customizeItem,
      this.image});
}
