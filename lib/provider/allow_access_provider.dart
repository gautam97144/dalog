import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/models/allow_access_model.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AllowAccessProvider extends ChangeNotifier {
  AllowAccessModel? _allowAccessModel;

  final List<AllowAccessModel> _listOfAccess = [
    AllowAccessModel(
      leading: AppAsset.locationIcon,
      boldTitle: "Location",
      title: " - Track your deliveries(Recommended)",
      trailing: false,
      onPressed: () {},
    ),
    AllowAccessModel(
        title: " - Stay informed each step of the way (Required)",
        trailing: false,
        boldTitle: "Notification",
        leading: AppAsset.notificationIcon,
        onPressed: () {}),
    AllowAccessModel(
        title: " - Take and upload pictures for your deliveries (Required)",
        trailing: false,
        boldTitle: "Camera",
        leading: AppAsset.cameraIcon,
        onPressed: () {})
  ];

  List<AllowAccessModel> get getAccessData => _listOfAccess;

  Future<void> allow(int index) async {
    if (index == 0) {
      if (await locationPermission().isGranted) {
        _listOfAccess[index].trailing = true;
      }
    } else if (index == 1) {
      if (await notificationPermission().isGranted) {
        _listOfAccess[index].trailing = true;
      }
    } else if (index == 2) {
      if (await cameraPermission().isGranted) {
        _listOfAccess[index].trailing = true;
      }
    }
    notifyListeners();
  }

  bool isAllowAllPermission() {
    return _listOfAccess.where((element) {
      return element.trailing == false;
    }).isEmpty;
  }

  static Future<PermissionStatus> locationPermission() async {
    final status = await Permission.location.request();

    return status;
  }

  static Future<PermissionStatus> cameraPermission() async {
    final status = await Permission.camera.request();

    return status;
  }

  static Future<PermissionStatus> notificationPermission() async {
    final status = await Permission.notification.request();

    if (status == PermissionStatus.denied) {
      await openAppSettings();
      notificationPermission();
    }
    return status;
  }
}
