import 'package:flutter/cupertino.dart';

class Diamension {
  String? name;
  bool isSelected;
  Diamension({required this.isSelected, this.name});
}

ValueNotifier<List<Diamension>> _diamension = ValueNotifier([
  Diamension(name: "Length", isSelected: false),
  Diamension(name: "Width", isSelected: false),
  Diamension(name: "Height", isSelected: false),
  Diamension(name: "Weight", isSelected: false),
]);

ValueNotifier<List<Diamension>> get diamension => _diamension;
