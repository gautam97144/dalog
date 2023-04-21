import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/pages/authantication/sign_up/Bloc/bloc.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import '../../../constant/constant.dart';
import '../../../routs/app_routs.dart';

class SignIn extends StatelessWidget with ValidationMixin {
  SignIn({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  VisibleBloc visibleBloc = GetIt.I<VisibleBloc>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: PrimaryPadding(child: scrollableColumn(context)),
      ),
    );
  }

  Widget scrollableColumn(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: Sizes.s30,
          ),
          appText("Welcome back!", style: AppTextStyle.headline1),
          appText("Please login with email & password",
              style: AppTextStyle.greySubTitle),
          const SizedBox(
            height: Sizes.s30,
          ),
          PrimaryTextField(
            controller: emailController,
            hintText: "Email",
            validator: (value) {
              return emailValidator(value, isLogin: true);
            },
          ),
          BlocBuilder<VisibleBloc, PasswordVisible>(
              bloc: visibleBloc,
              builder: (context, state) {
                return PrimaryTextField(
                  //  instructions: false,
                  controller: passwordController,
                  obscureText: state.isObsecureText,
                  validator: (value) {
                    return passwordValidator(value, isLogin: true);
                  },
                  hintText: "Password",
                  suffix: InkWell(
                    onTap: () {
                      visibleBloc.update(
                          !state.isVisible, !state.isObsecureText);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(right: Sizes.s10.w),
                        child: state.isVisible
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
              }),
          const SizedBox(
            height: Sizes.s10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routs.forgotPassword);
              },
              child: appText("Forgot Password?",
                  style: AppTextStyle.redTextStyle
                      .copyWith(color: AppColor.primaryColor)),
            ),
          ]),
          const SizedBox(
            height: Sizes.s20,
          ),
          PrimaryButton(
              lable: "Login",
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await ApiService().loginUser(context, data: data());
                }
                //Navigator.pushNamed(context, Routs.forgotPassword);
              }),
          const SizedBox(
            height: Sizes.s50,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appText("You don’t have an account?",
                    style: AppTextStyle.blackSubTitle),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, Routs.signUp);
                    },
                    child:
                        appText("Register", style: AppTextStyle.redTextStyle)),
              ],
            ),
          ]),
        ],
      ),
    );
  }

  FormData data() {
    return FormData.fromMap({
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": "abc"
    });
  }
}
