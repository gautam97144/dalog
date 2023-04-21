import 'package:dalog_distribution/routs/app_routs.dart';

class ProfileSetting {
  String? name;
  String? route;
  ProfileSetting({this.name, this.route});
}

List<ProfileSetting> _profileSetting = [
  ProfileSetting(name: "Change Password", route: Routs.changePassword),
  ProfileSetting(name: "Change phone number", route: Routs.changePhoneNumber),
  ProfileSetting(name: "Change Language", route: Routs.changeLanguage),
  ProfileSetting(name: "About us", route: Routs.aboutUs),
  ProfileSetting(name: "Help & support", route: Routs.helpAndSupport),
  ProfileSetting(name: "Terms & conditions", route: Routs.termsAndCond),
];

List<ProfileSetting> get profileSetting => _profileSetting;
