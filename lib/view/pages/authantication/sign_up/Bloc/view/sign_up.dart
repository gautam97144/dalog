import 'package:country_calling_code_picker/country.dart';
import 'package:country_calling_code_picker/functions.dart';
import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/services/function.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with ValidationMixin {
  Country? selectCountry;
  ValueNotifier<bool> isSelected = ValueNotifier(false);
  ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);
  ValueNotifier<bool> isConfirmPasswordVisible = ValueNotifier(false);

  final _formKey = GlobalKey<FormState>();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: _formKey,
        child: CustomHeader(
          header: "Register",
          subTitle: "Fill your details to continue",
          children: Column(
            children: [
              Row(children: [
                Flexible(
                    child: PrimaryTextField(
                  hintText: "First Name",
                  controller: firstName,
                  validator: firstNameValidator,
                )),
                SizedBox(
                  width: Sizes.s8.w,
                ),
                Flexible(
                    child: PrimaryTextField(
                        hintText: "Last Name",
                        controller: lastName,
                        validator: lastNameValidator)),
              ]),
              PrimaryTextField(
                hintText: "Email Address",
                controller: emailAddress,
                validator: emailValidator,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _initCountry(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
                      height: Sizes.s50.h,
                      constraints: BoxConstraints(minWidth: Sizes.s40.w),
                      //width: ScreenUtil().screenWidth / 4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: Theme.of(context).cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          appText(selectCountry?.callingCode ?? "+1",
                              style: AppTextStyle.subTitle
                                  .copyWith(fontWeight: FontWeight.w900)),
                          const Icon(Icons.keyboard_arrow_down_outlined)
                        ],
                      ),
                    ),
                  ),
                  // Flexible(
                  //     child: PrimaryTextField(
                  //   hintText: "+91",
                  //   suffix: Icon(
                  //     Icons.keyboard_arrow_down_outlined,
                  //     color: AppColor.black,
                  //   ),
                  // )
                  // ),
                  SizedBox(
                    width: Sizes.s8.w,
                  ),
                  Flexible(
                      flex: 3,
                      child: PrimaryTextField(
                        hintText: 'Mobile Number',
                        controller: mobileNumber,
                        validator: mobileNumberValidator,
                      ))
                ],
              ),
              ValueListenableBuilder(
                valueListenable: isPasswordVisible,
                builder: (BuildContext context, value, Widget? child) {
                  return PrimaryTextField(
                    obscureText: isPasswordVisible.value,
                    hintText: "Password",
                    controller: password,
                    validator: passwordValidator,
                    suffix: Padding(
                      padding: EdgeInsets.only(right: Sizes.s10.w),
                      child: InkWell(
                          onTap: () {
                            isPasswordVisible.value = !isPasswordVisible.value;
                          },
                          child: isPasswordVisible.value == true
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
                  );
                },
              ),
              ValueListenableBuilder(
                  valueListenable: isConfirmPasswordVisible,
                  builder: (BuildContext context, value, Widget? child) {
                    return PrimaryTextField(
                      obscureText: isConfirmPasswordVisible.value,
                      hintText: "Confirm Password",
                      controller: confirmPassword,
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
                      validator: (value) {
                        return confirmPasswordValidator(
                            value!, password.text.trim());
                      },
                    );
                  }),
              SizedBox(
                height: Sizes.s12.h,
              ),
              // TextFormField(
              //   validator: (value) {
              //     if (value == "") {
              //       return "enter name";
              //     }
              //     return null;
              //   },
              // ),
              _termsAndCondition(),
              SizedBox(
                height: Sizes.s20.h,
              ),
              PrimaryButton(
                  lable: "Register",
                  onPressed: () async {
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (context) => Otp()));
                    if (_formKey.currentState!.validate()) {
                      if (isSelected.value == true) {
                        await ApiService().signUp(context, data: data());
                      } else {
                        return CommonFunctions.toast(
                            "Please accept terms and condition");
                      }
                    }
                  }),
              SizedBox(
                height: Sizes.s20.h,
              ),
              _divider(),
              SizedBox(
                height: Sizes.s20.h,
              ),
              socialButton()
            ],
          ),
        ),
      ),
    );
  }

  FormData data() {
    return FormData.fromMap({
      "first_name": firstName.text,
      "last_name": lastName.text,
      "email": emailAddress.text,
      "country_code": selectCountry?.callingCode,
      "phone_number": mobileNumber.text,
      "password": password.text,
      "type": "1",
      "social_id": "abc",
      "device_token": "abc"
    });
  }

  Widget _termsAndCondition() {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: isSelected,
          builder: (BuildContext context, bool value, Widget? child) {
            return InkWell(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                isSelected.value = !isSelected.value;
              },
              child: isSelected.value == true
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColor.red,
                    )
                  : const Icon(Icons.radio_button_unchecked),
            );
          },
        ),
        SizedBox(
          width: Sizes.s4.w,
        ),
        appText("Accept our", style: AppTextStyle.blackSubTitle),
        appText("Terms&Condition",
            style: TextStyle(
              fontSize: Sizes.s14.sp,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.underline,
            ))
      ],
    );
  }

  Widget _divider() {
    return Row(children: [
      const Expanded(
          child: Divider(
        thickness: 2,
      )),
      SizedBox(
        width: Sizes.s5.w,
      ),
      appText(
        "OR",
        style: AppTextStyle.subTitle.copyWith(fontWeight: FontWeight.w400),
      ),
      SizedBox(
        width: Sizes.s5.w,
      ),
      const Expanded(
          child: Divider(
        thickness: 2,
      )),
    ]);
  }

  Widget socialButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SvgPicture.asset(
          AppAsset.appleIcon,
          height: Sizes.s46.h,
          width: Sizes.s46.w,
        ),
        SvgPicture.asset(
          AppAsset.facebookIcon,
          height: Sizes.s46.h,
          width: Sizes.s46.w,
        ),
        SvgPicture.asset(
          AppAsset.googleIcon,
          height: Sizes.s46.h,
          width: Sizes.s46.w,
        )
      ],
    );
  }

  void _initCountry(BuildContext context) async {
    final country = await showCountryPickerDialog(context,
        focusSearchBox: false, cornerRadius: 0);
    setState(() {
      selectCountry = country;
    });
  }
}
