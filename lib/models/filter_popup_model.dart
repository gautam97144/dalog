import 'package:dalog_distribution/constant/constant.dart';

class Filter {
  String? image;
  String? day;
  String? date;

  Filter({this.image, this.day, this.date});

  static final List<Filter> _filter = [
    Filter(image: AppAsset.calendar, day: "Today", date: "Aug 18"),
    Filter(image: AppAsset.calendar, day: "Yesterday", date: "Aug 20"),
    Filter(image: AppAsset.calendar, day: "Last Week", date: "Aug 10-19"),
    Filter(image: AppAsset.calendar, day: "Last Month", date: "Aug 1-31"),
  ];
  static List<Filter> get getFilter => _filter;
}
