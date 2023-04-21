import 'package:flutter/material.dart';

class DebitCardData {
  String? name;
  String? expiryDate;
  String? cardNo;
  bool isSelected;

  DebitCardData(
      {this.name, this.expiryDate, this.cardNo, required this.isSelected});
}

final ValueNotifier<List<DebitCardData>> _debitCard = ValueNotifier([
  DebitCardData(
      name: "MasterCard",
      isSelected: false,
      expiryDate: "12/23",
      cardNo: "...1234"),
  DebitCardData(
      name: "MasterCard",
      isSelected: false,
      expiryDate: "12/26",
      cardNo: "...1256"),
  DebitCardData(
      name: "MasterCard",
      isSelected: false,
      expiryDate: "12/28",
      cardNo: "...1298")
]);

ValueNotifier<List<DebitCardData>> get debitCard => _debitCard;
