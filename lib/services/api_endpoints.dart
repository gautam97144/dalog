import 'package:flutter/material.dart';

class EndPoints {
  static const String baseUrl = "http://18.188.34.79:3000/";
  static const String imageUrl = "${baseUrl}uploads/";
  //"https://dalog.herokuapp.com/api/user/";
  //"http://3.110.120.210:3000/api/user/";
  static const String uploadImageUrl = "upload-img";
  static const String signUp = "api/user/signup";
  static const String verifyOtp = "api/user/otp-check";
  static const String resendOtp = "api/user/resend-otp";
  static const String login = "api/user/login";
  static const String forgotPassword = "api/user/forgot-password";
  static const String otpCheckResetPassword = "api/user/otp-check-reset-pass";
  static const String resetPassword = "api/user/set-password";
  static const String updateProfile = "api/user/update-profile";
  static const String changePassword = "api/user/change-password";
  static const String createjob = "api/job/createjob";
  static const String myOpenJobList = "${baseUrl}api/user/my-open-job-list";
  static const String draftJobList = "${baseUrl}api/user/draft-job-list";
  static const String myCompletedJobList = "${baseUrl}api/user/my-completed-job-list";
  static const String deleteJob = "${baseUrl}api/job/deletejob";

  //static const String createJob = "http://18.188.34.79:3000/api/job/createjob";
}
