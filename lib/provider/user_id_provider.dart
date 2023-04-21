import 'package:flutter/material.dart';

class UserId extends ChangeNotifier {
  String? userId;

  setUserId({String? userid}) {
    userId = userid;
    notifyListeners();
  }
}
