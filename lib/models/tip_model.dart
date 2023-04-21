import 'package:flutter/cupertino.dart';

class Tip {
  String? name;
  bool isSelected;

  Tip({this.name, required this.isSelected});
}

ValueNotifier<List<Tip>> _tip = ValueNotifier([
  Tip(name: "\$1", isSelected: false),
  Tip(name: "\$3", isSelected: false),
  Tip(name: "\$5", isSelected: false),
  Tip(name: "\$7", isSelected: false),
  Tip(name: "\$9", isSelected: false)
]);

ValueNotifier<List<Tip>> get tip => _tip;
