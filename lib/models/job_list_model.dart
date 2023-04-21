import 'package:flutter/material.dart';

class GetJobListModel {
  bool? sucecess;
  List<GetJobListDataModel>? data;
  int? totalJob;
  String? message;

  GetJobListModel({this.sucecess, this.data, this.totalJob, this.message});

  GetJobListModel.fromJson(Map<String, dynamic> json) {
    sucecess = json['sucecess'];
    if (json['data'] != null) {
      data = <GetJobListDataModel>[];
      json['data'].forEach((v) {
        data!.add(new GetJobListDataModel.fromJson(v));
      });
    }
    totalJob = json['totalJob'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sucecess'] = this.sucecess;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['totalJob'] = this.totalJob;
    data['message'] = this.message;
    return data;
  }
}

class GetJobListDataModel {
  String? userId;
  String? jobTittle;
  String? pickupLocation;
  String? pickupDate;
  String? pickupTime;
  String? pickupAddress;
  String? pickupAddress2;
  String? pickupCity;
  String? pickupState;
  String? pickupZipcode;
  String? pickupCountry;
  String? pickupLat;
  String? pickupLong;
  String? dropoffaddress;
  String? dropoffaddress2;
  String? dropoffcity;
  String? dropoffstate;
  String? dropoffzipcode;
  String? dropoffcountry;
  String? dropofflat;
  String? dropofflong;
  String? specialInstructions;
  String? dropoffdate;
  String? dropofftime;
  Null? dropoffassoonaspossible;
  List<CustomizeItem>? customizeItem;
  String? itemName;
  String? itemValue;
  String? cost;
  String? serviceFees;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? id;
  bool? isSelected =false;
  GlobalKey? menuKey;

  GetJobListDataModel(
      {this.userId,
        this.jobTittle,
        this.pickupLocation,
        this.pickupDate,
        this.pickupTime,
        this.pickupAddress,
        this.pickupAddress2,
        this.pickupCity,
        this.pickupState,
        this.pickupZipcode,
        this.pickupCountry,
        this.pickupLat,
        this.pickupLong,
        this.dropoffaddress,
        this.dropoffaddress2,
        this.dropoffcity,
        this.dropoffstate,
        this.dropoffzipcode,
        this.dropoffcountry,
        this.dropofflat,
        this.dropofflong,
        this.specialInstructions,
        this.dropoffdate,
        this.dropofftime,
        this.dropoffassoonaspossible,
        this.customizeItem,
        this.itemName,
        this.itemValue,
        this.cost,
        this.serviceFees,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.id,
      this.isSelected=false,
      this.menuKey});

  GetJobListDataModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    jobTittle = json['job_tittle'];
    pickupLocation = json['pickup_location'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    pickupAddress = json['pickup_address'];
    pickupAddress2 = json['pickup_address2'];
    pickupCity = json['pickup_city'];
    pickupState = json['pickup_state'];
    pickupZipcode = json['pickup_zipcode'];
    pickupCountry = json['pickup_country'];
    pickupLat = json['pickup_lat'];
    pickupLong = json['pickup_long'];
    dropoffaddress = json['dropoffaddress'];
    dropoffaddress2 = json['dropoffaddress2'];
    dropoffcity = json['dropoffcity'];
    dropoffstate = json['dropoffstate'];
    dropoffzipcode = json['dropoffzipcode'];
    dropoffcountry = json['dropoffcountry'];
    dropofflat = json['dropofflat'];
    dropofflong = json['dropofflong'];
    specialInstructions = json['special_instructions'];
    dropoffdate = json['dropoffdate'];
    dropofftime = json['dropofftime'];
    dropoffassoonaspossible = json['dropoffassoonaspossible'];
    if (json['customize_item'] != null) {
      customizeItem = <CustomizeItem>[];
      json['customize_item'].forEach((v) {
        customizeItem!.add(new CustomizeItem.fromJson(v));
      });
    }
    itemName = json['item_name'];
    itemValue = json['item_value'];
    cost = json['cost'];
    serviceFees = json['service_fees'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['job_tittle'] = this.jobTittle;
    data['pickup_location'] = this.pickupLocation;
    data['pickup_date'] = this.pickupDate;
    data['pickup_time'] = this.pickupTime;
    data['pickup_address'] = this.pickupAddress;
    data['pickup_address2'] = this.pickupAddress2;
    data['pickup_city'] = this.pickupCity;
    data['pickup_state'] = this.pickupState;
    data['pickup_zipcode'] = this.pickupZipcode;
    data['pickup_country'] = this.pickupCountry;
    data['pickup_lat'] = this.pickupLat;
    data['pickup_long'] = this.pickupLong;
    data['dropoffaddress'] = this.dropoffaddress;
    data['dropoffaddress2'] = this.dropoffaddress2;
    data['dropoffcity'] = this.dropoffcity;
    data['dropoffstate'] = this.dropoffstate;
    data['dropoffzipcode'] = this.dropoffzipcode;
    data['dropoffcountry'] = this.dropoffcountry;
    data['dropofflat'] = this.dropofflat;
    data['dropofflong'] = this.dropofflong;
    data['special_instructions'] = this.specialInstructions;
    data['dropoffdate'] = this.dropoffdate;
    data['dropofftime'] = this.dropofftime;
    data['dropoffassoonaspossible'] = this.dropoffassoonaspossible;
    if (this.customizeItem != null) {
      data['customize_item'] =
          this.customizeItem!.map((v) => v.toJson()).toList();
    }
    data['item_name'] = this.itemName;
    data['item_value'] = this.itemValue;
    data['cost'] = this.cost;
    data['service_fees'] = this.serviceFees;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['id'] = this.id;
    return data;
  }
}

class CustomizeItem {
  String? image;
  String? quantities;
  String? length;

  CustomizeItem({this.image, this.quantities, this.length});

  CustomizeItem.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    quantities = json['quantities'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['quantities'] = this.quantities;
    data['length'] = this.length;
    return data;
  }
}
