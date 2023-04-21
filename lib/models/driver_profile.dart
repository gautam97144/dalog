import 'package:dalog_distribution/constant/constant.dart';

class DriverProfile {
  String? name;
  String? image;
  String? date;
  String? reviewCount;
  String? deliveryCount;
  DriverProfile(
      {this.name, this.deliveryCount, this.image, this.date, this.reviewCount});
}

List<DriverProfile> _driverProfile = [
  DriverProfile(
      name: "Feni Olgano",
      reviewCount: "2.5",
      date: "10 feb 2022",
      image: AppAsset.driverOne,
      deliveryCount: "100"),
  DriverProfile(
      name: "Doodo Poppins",
      reviewCount: "4.3",
      date: "10 oct 2022",
      deliveryCount: "130",
      image: AppAsset.driverTwo),
  DriverProfile(
      name: "Lato Sansanti",
      reviewCount: "3.5",
      date: "10 nov 2022",
      deliveryCount: "120",
      image: AppAsset.driverThree),
];
List<DriverProfile> get driverProfile => _driverProfile;
