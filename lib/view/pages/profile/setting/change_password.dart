import 'dart:convert';

import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/helper/validation.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/verify_otp.dart';
import '../../../../provider/user_id_provider.dart';

class ChangePassword extends StatelessWidget with ValidationMixin {
  ChangePassword({Key? key}) : super(key: key);

  VerifyOtp? user;
  final _formKey = GlobalKey<FormState>();

  ValueNotifier<bool> oldPasswordSuffixIcon = ValueNotifier(true);
  ValueNotifier<bool> newPasswordSuffixIcon = ValueNotifier(true);
  ValueNotifier<bool> confirmPasswordSuffixIcon = ValueNotifier(true);

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  List<String> days = [
    "monday",
    "tuesday",
    "Wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];
  String name = "gautam";

  @override
  Widget build(BuildContext context) {
    //ApiService().changePassword(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: PrimaryPadding(
            verticalPadding: Sizes.s10.h,
            child: PrimaryButton(
                lable: "Save",
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await ApiService().changePassword(
                        context,
                        oldPassword.text.trim().toString(),
                        newPassword.text.trim().toString());
                  }
                })),
      ),
      appBar: SecondaryAppBar(
        title: "Change Password",
      ),
      body: Form(
        key: _formKey,
        child: CustomScroll(
          children: [
            CustomSizedBox(),
            ValueListenableBuilder(
              valueListenable: oldPasswordSuffixIcon,
              builder: (BuildContext context, bool value, Widget? child) {
                return PrimaryTextField(
                    controller: oldPassword,
                    obscureText: oldPasswordSuffixIcon.value,
                    hintText: "Old password",
                    validator: oldPasswordValidator,
                    suffix: InkWell(
                      onTap: () {
                        oldPasswordSuffixIcon.value =
                            !oldPasswordSuffixIcon.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: Sizes.s10.h),
                        child: oldPasswordSuffixIcon.value == true
                            ? SvgPicture.asset(AppAsset.unVisible,
                                height: Sizes.s4.h,
                                width: Sizes.s4.h,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.white
                                    : AppColor.black)
                            : SvgPicture.asset(AppAsset.visible,
                                height: Sizes.s4.h,
                                width: Sizes.s4.h,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.white
                                    : AppColor.black),
                      ),
                    ));
              },
            ),
            ValueListenableBuilder(
              valueListenable: newPasswordSuffixIcon,
              builder: (BuildContext context, bool value, Widget? child) {
                return PrimaryTextField(
                    hintText: "New password",
                    controller: newPassword,
                    obscureText: newPasswordSuffixIcon.value,
                    validator: (value) {
                      return passwordValidator(value, isLogin: true);
                    },
                    suffix: InkWell(
                      onTap: () {
                        newPasswordSuffixIcon.value =
                            !newPasswordSuffixIcon.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: Sizes.s10.h),
                        child: newPasswordSuffixIcon.value == true
                            ? SvgPicture.asset(AppAsset.unVisible,
                                height: Sizes.s4.h,
                                width: Sizes.s4.h,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.white
                                    : AppColor.black)
                            : SvgPicture.asset(AppAsset.visible,
                                height: Sizes.s4.h,
                                width: Sizes.s4.h,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.white
                                    : AppColor.black),
                      ),
                    ));
              },
            ),
            ValueListenableBuilder(
              valueListenable: confirmPasswordSuffixIcon,
              builder: (BuildContext context, bool value, Widget? child) {
                return PrimaryTextField(
                    hintText: "Confirm password",
                    obscureText: confirmPasswordSuffixIcon.value,
                    controller: confirmPassword,
                    validator: (value) {
                      return confirmPasswordValidator(
                          value!, newPassword.text.trim());
                    },
                    suffix: InkWell(
                      onTap: () {
                        confirmPasswordSuffixIcon.value =
                            !confirmPasswordSuffixIcon.value;
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: Sizes.s10.h),
                        child: confirmPasswordSuffixIcon.value == true
                            ? SvgPicture.asset(AppAsset.unVisible,
                                height: Sizes.s4.h,
                                width: Sizes.s4.h,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.white
                                    : AppColor.black)
                            : SvgPicture.asset(AppAsset.visible,
                                height: Sizes.s4.h,
                                width: Sizes.s4.h,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.white
                                    : AppColor.black),
                      ),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }

  getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userData = preferences.getString("user");
    user = VerifyOtp.fromJson(jsonDecode(userData!));
    //print(user.token);
  }

  // FormData data() {
  //   return FormData.fromMap({
  //     "user_id": userId.toString(),
  //     "old_password": oldPassword.text.toString(),
  //     "new_password": newPassword.text.toString()
  //   });
  // }
}
