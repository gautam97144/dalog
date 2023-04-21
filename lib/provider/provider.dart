import 'package:flutter/material.dart';

import '../../models/language_model.dart';

class LanguageSelectionProvider extends ChangeNotifier {
  LanguageSelection? languageSelection;

  final List<LanguageSelection> _laguageselected = [
    LanguageSelection(
        title: "English",
        isSelected: true,
        languageLocal: const Locale("en", "GB")),
    LanguageSelection(
        title: "French",
        isSelected: false,
        languageLocal: const Locale('fr', 'FR')),
    LanguageSelection(
      title: "Spanish",
      isSelected: false,
      languageLocal: const Locale('es', 'ES'),
    )
  ];

  List<LanguageSelection> get getLangugeList => _laguageselected;

  void update(int index) {
    for (var element in _laguageselected) {
      element.isSelected = false;
    }
    _laguageselected[index].isSelected = true;

    notifyListeners();
  }
}
