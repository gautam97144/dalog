import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dalog_distribution/view/pages/authantication/verify_otp.dart';
import 'package:dalog_distribution/view/pages/permission/allow_access.dart';
import 'package:dalog_distribution/view/pages/profile/setting/change_language.dart';
import 'package:dalog_distribution/view/pages/profile/setting/change_password.dart';
import 'package:dalog_distribution/view/pages/profile/driver/driver.dart';
import 'package:dalog_distribution/view/pages/profile/driver/filter.dart';
import 'package:dalog_distribution/view/pages/profile/driver/search_driver_list.dart';
import 'package:dalog_distribution/view/pages/profile/setting/help_and_support.dart';
import 'package:dalog_distribution/view/pages/profile/my_profile/profile.dart';
import 'package:dalog_distribution/view/pages/splash/splash.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../view/pages/authantication/reset_password.dart';
import '../view/pages/home/completed_job.dart';
import '../view/pages/home/create_job/creat_job.dart';
import '../view/pages/home/create_job/create_job_second/create_job_second.dart';
import '../view/pages/home/driver_rating.dart';
import '../view/pages/home/job_terms_and_condition.dart';
import '../view/pages/home/open_job/open_job.dart';
import '../view/pages/authantication/forgot_password.dart';
import '../view/pages/authantication/login.dart';
import '../view/pages/authantication/sign_up/Bloc/view/sign_up.dart';
import '../view/pages/home/pay_tip.dart';
import '../view/pages/permission/choose_language.dart';
import '../view/pages/profile/setting/about_us.dart';
import '../view/pages/profile/driver/driver_profile.dart';
import '../view/pages/profile/notification/notification.dart';
import '../view/pages/profile/payment_meyhod/payment_method.dart';
import '../view/pages/profile/setting/setting.dart';
import '../view/pages/profile/setting/change_phone_number.dart';
import '../view/pages/profile/setting/terms_and_condition.dart';

class Routs {
  static const String splash = "/splash";
  static const String allowAccess = "/allowAccess";
  static const String chooseLanguage = "/chooseLanguage";
  static const String login = "/login";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String resetPassword = "/changePassword";
  static const String otp = "/otp";
  static const String createJob = "/creatJob";
  static const String createJobSecond = "/create_job_second";
  static const String termsAndCondition = "/job_terms_and_condition";
  static const String openJob = "/open_job";
  static const String driverRating = "/driver_rating";
  static const String payTip = "/pay_tip";
  static const String setting = "/setting";
  static const String profile = "/profile";
  static const String changePassword = "/change_password";
  static const String changePhoneNumber = "/changePhoneNumber";
  static const String aboutUs = "/aboutUs";
  static const String helpAndSupport = "/help_and_support";
  static const String termsAndCond = "/terms_and_condition";
  static const String notification = "/notification";
  static const String paymentMethod = "/payment_method";
  static const String completedJob = "/completed_job";
  static const String driver = "/driver";
  static const String searchDriver = "/search_driver_list";
  static const String filter = "/filter";
  static const String driverProfile = "/driver_profile";
  static const String bottomNavigation = "/bottom_navigation";
  static const String changeLanguage = "/change_language";
}

class RoutGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    var arguments = settings.arguments;

    switch (settings.name) {
      case Routs.splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case Routs.chooseLanguage:
        return MaterialPageRoute(builder: (_) => ChooseLanguage());
      case Routs.allowAccess:
        return MaterialPageRoute(builder: (_) => const AllowAccess());

      case Routs.login:
        return MaterialPageRoute(builder: (_) => SignIn());

      case Routs.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());

      case Routs.resetPassword:
        return MaterialPageRoute(
            builder: (_) => ResetPassword(arguments as OtpArguments));

      case Routs.signUp:
        return MaterialPageRoute(builder: (_) => SignUp());

      case Routs.otp:
        return MaterialPageRoute(
            builder: (_) => Otp(arguments as OtpArguments));

      case Routs.createJob:
        return MaterialPageRoute(builder: (_) => CreatJob());

      case Routs.createJobSecond:
        return MaterialPageRoute(
            builder: (_) => CreatJobSecond(arguments as CreateJobModel));

      case Routs.termsAndCondition:
        return MaterialPageRoute(
            builder: (_) =>
                JobTermsAndCondition(arguments as CreateJobSecondModel));

      case Routs.openJob:
        return MaterialPageRoute(builder: (_) => OpenJob());

      case Routs.driverRating:
        return MaterialPageRoute(builder: (_) => DriverRating());

      case Routs.payTip:
        return MaterialPageRoute(builder: (_) => const PayTip());

      case Routs.setting:
        return MaterialPageRoute(builder: (_) => const Setting());

      case Routs.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePassword());

      case Routs.profile:
        return MaterialPageRoute(builder: (_) => Profile());

      case Routs.changePhoneNumber:
        return MaterialPageRoute(builder: (_) => const ChangePhoneNumber());

      case Routs.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutUs());

      case Routs.helpAndSupport:
        return MaterialPageRoute(builder: (_) => const HelpAndSupport());

      case Routs.termsAndCond:
        return MaterialPageRoute(builder: (_) => const TermsAndCondition());

      case Routs.notification:
        return MaterialPageRoute(builder: (_) => const NotificationList());

      case Routs.paymentMethod:
        return MaterialPageRoute(builder: (_) => const PaymentMethod());

      case Routs.completedJob:
        return MaterialPageRoute(builder: (_) => CompletedJob());

      case Routs.driver:
        return MaterialPageRoute(builder: (_) => const Driver());

      case Routs.searchDriver:
        return MaterialPageRoute(builder: (_) => SearchDriverList());

      case Routs.filter:
        return MaterialPageRoute(builder: (_) => const FilterBy());

      case Routs.driverProfile:
        return MaterialPageRoute(builder: (_) => const DriverProfileDetail());

      case Routs.bottomNavigation:
        return MaterialPageRoute(builder: (_) => CustomBottomNavigation());

      case Routs.changeLanguage:
        return MaterialPageRoute(builder: (_) => ChangeLanguage());

      default:
        return null;
    }
  }
}
