import 'package:flutter/material.dart';

class JobIssue {
  String? data;
  bool? isSelected;

  JobIssue({this.data, this.isSelected});
}

final ValueNotifier<List<JobIssue>> _jobIssue = ValueNotifier([
  JobIssue(data: "Missing items", isSelected: false),
  JobIssue(data: "Damaged items", isSelected: false),
]);

ValueNotifier<List<JobIssue>> get jobIssue => _jobIssue;
