import 'package:flutter/cupertino.dart';

class AllowAccessModel {
  String? title;
  String? boldTitle;
  String? leading;
  bool trailing;
  VoidCallback? onPressed;

  AllowAccessModel(
      {this.title,
      required this.trailing,
      this.leading,
      this.boldTitle,
      this.onPressed});
}
