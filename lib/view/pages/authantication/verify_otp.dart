import 'dart:developer';

import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/services/function.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../routs/app_routs.dart';
import '../../../utils/loder.dart';

class Otp extends StatelessWidget {
  final OtpArguments? arguments;
  Otp(this.arguments, {Key? key}) : super(key: key);

  String? _controller;
  @override
  Widget build(BuildContext context) {
    print(arguments?.id);
    return Scaffold(
      appBar: CustomAppBar(),
      body: CustomHeader(
        header: "Verification Code",
        subTitle: "Enter 4 digit code sent to your Email ",
        children: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s24.w),
              child: OTPTextField(
                //cursorColor: AppColor.primaryColor,
                // margin: EdgeInsets.symmetric(horizontal: Sizes.s10.h),
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 65,
                keyboardType: TextInputType.number,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceEvenly,
                fieldStyle: FieldStyle.box,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: Sizes.s6.w, vertical: Sizes.s20.h),
                otpFieldStyle: OtpFieldStyle(
                    enabledBorderColor: Theme.of(context).cardColor,
                    focusBorderColor: Theme.of(context).cardColor,
                    backgroundColor: Theme.of(context).cardColor),
                onCompleted: (pin) {
                  _controller = pin;
                },
              ),
            ),
            SizedBox(
              height: Sizes.s20.h,
            ),
            PrimaryButton(
                lable: 'Verify',
                onPressed: () async {
                  // Navigator.pushNamed(context, Routs.bottomNavigation);

                  FormData formData = FormData.fromMap(
                      {"id": arguments?.id, "otp": _controller});
                  if (_controller != null) {
                    if (arguments?.status == 1) {
                      log("hello");
                      await ApiService()
                          .otpVerifyResetPassword(context, data: formData)
                          .whenComplete(() {
                        Loader.hideLoader();
                      });
                    } else {
                      log("good morning");
                      await ApiService()
                          .verifyOtp(context, data: data(), status: 1);
                    }
                  } else {
                    CommonFunctions.toast("Enter otp");
                  }
                }),
            SizedBox(height: Sizes.s20.h),
            GestureDetector(
                onTap: () async {
                  FormData data = FormData.fromMap({"id": arguments?.id});
                  await ApiService().resendOtp(data: data);
                },
                child: appText("Resend Code", style: AppTextStyle.redTextStyle))
          ],
        ),
      ),
    );
  }

  FormData data() {
    return FormData.fromMap({"id": arguments?.id, "otp": _controller});
  }
}
