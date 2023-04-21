import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../routs/app_routs.dart';

class ResetPassword extends StatelessWidget with ValidationMixin {
  final OtpArguments? arguments;

  ResetPassword(
    this.arguments, {
    Key? key,
  }) : super(key: key);

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ValueNotifier<bool> isVisible = ValueNotifier(true);
  ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(true);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(arguments?.id);
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomHeader(
        header: "Reset Password",
        subTitle: "Enter new password here",
        children: Form(
          key: formKey,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: isVisible,
                builder: (BuildContext context, bool value, Widget? child) {
                  return PrimaryTextField(
                    obscureText: isVisible.value,
                    suffix: Padding(
                      padding: EdgeInsets.only(right: Sizes.s10.w),
                      child: InkWell(
                          onTap: () {
                            isVisible.value = !isVisible.value;
                          },
                          child: isVisible.value == true
                              ? SvgPicture.asset(
                                  AppAsset.unVisible,
                                  height: Sizes.s4.h,
                                  width: Sizes.s4.h,
                                  color: Theme.of(context).brightness ==
                                          ThemeUtils.darkTheme.brightness
                                      ? AppColor.white
                                      : AppColor.black,
                                )
                              : SvgPicture.asset(
                                  AppAsset.visible,
                                  height: Sizes.s4.h,
                                  width: Sizes.s4.h,
                                  color: Theme.of(context).brightness ==
                                          ThemeUtils.darkTheme.brightness
                                      ? AppColor.white
                                      : AppColor.black,
                                )),
                    ),
                    instructions: true,
                    hintText: "Password",
                    controller: passwordController,
                    validator: passwordValidator,
                    instructionsText: "Must be at least 8 characters",
                  );
                },
              ),
              SizedBoxH10(),
              ValueListenableBuilder(
                valueListenable: isConfirmPasswordVisible,
                builder: (BuildContext context, value, Widget? child) {
                  return PrimaryTextField(
                    obscureText: isConfirmPasswordVisible.value,
                    suffix: Padding(
                      padding: EdgeInsets.only(right: Sizes.s10.w),
                      child: InkWell(
                          onTap: () {
                            isConfirmPasswordVisible.value =
                                !isConfirmPasswordVisible.value;
                          },
                          child: isConfirmPasswordVisible.value == true
                              ? SvgPicture.asset(
                                  AppAsset.unVisible,
                                  height: Sizes.s4.h,
                                  width: Sizes.s4.h,
                                  color: Theme.of(context).brightness ==
                                          ThemeUtils.darkTheme.brightness
                                      ? AppColor.white
                                      : AppColor.black,
                                )
                              : SvgPicture.asset(
                                  AppAsset.visible,
                                  height: Sizes.s4.h,
                                  width: Sizes.s4.h,
                                  color: Theme.of(context).brightness ==
                                          ThemeUtils.darkTheme.brightness
                                      ? AppColor.white
                                      : AppColor.black,
                                )),
                    ),
                    instructions: true,
                    hintText: "Confirm Password",
                    validator: (value) {
                      return confirmPasswordValidator(
                          value!, passwordController.text.trim());
                    },
                    controller: confirmPasswordController,
                    instructionsText: "Must be at least 8 characters",
                  );
                },
              ),
              SizedBoxH14(),
              PrimaryButton(
                  lable: "Reset",
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await ApiService().resetPassword(context, data: data());
                    }
                    //Navigator.pushNamed(context, Routs.signUp);
                  })
            ],
          ),
        ),
      ),
    );
  }

  FormData data() {
    return FormData.fromMap(
        {"id": arguments?.id, "password": passwordController.text});
  }
}
