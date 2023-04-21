import 'package:dalog_distribution/view/pages/home/create_job/create_job_second/create_job_second.dart';
import 'package:flutter/material.dart';

class ImageData extends ChangeNotifier {
  AddItem? addItem;

  List<AddItem> addedItem = [];
  setImageData({AddItem? addItem}) {
    this.addItem = addItem;
    addedItem.add(addItem!);
    notifyListeners();
  }

  removeImageData(int index) {
    addedItem.removeAt(index);
    notifyListeners();
  }
}

// class ImageAdd extends ChangeNotifier {
//   List<ImageData?> addImageData = [];
//
//   addItem({ImageData? imageData}) {
//     addImageData.add(imageData);
//     notifyListeners();
//   }
//addImageData(){}

//}
