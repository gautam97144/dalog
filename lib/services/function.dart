import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/constant.dart';

class CommonFunctions {
  static void toast(String info) {
    Fluttertoast.showToast(
      timeInSecForIosWeb: 1,
      msg: info,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static Future<bool> checkConnectivity() async {
    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        print("Please turn on mobile data or wifi!");
        CommonFunctions.toast(
            "please check you mobile data or wifi connection!");
        return false;
      } else {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          print("Please check your internet connectivity!");
          CommonFunctions.toast(
              "please check you mobile data or wifi connection!");
          return false;
        }
      }
    } on SocketException catch (_) {
      print("No Internet !");
      CommonFunctions.toast("please check you mobile data or wifi connection!");
      return false;
    }
  }
}
