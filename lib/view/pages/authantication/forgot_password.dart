import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget with ValidationMixin {
  ForgotPassword({Key? key}) : super(key: key);

  TextEditingController controller = TextEditingController();

  final formKey = GlobalKey<FormState>();

  dynamic userData;

  @override
  Widget build(BuildContext context) {
    //   getData();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Form(
        key: formKey,
        child: CustomHeader(
          header: "Forgot Password",
          subTitle:
              'Enter registered email and we will send you a reset password link',
          children: Column(mainAxisSize: MainAxisSize.min, children: [
            PrimaryTextField(
                instructions: true,
                validator: (value) {
                  return emailValidator(value, isLogin: true);
                },
                hintText: "Email",
                controller: controller),
            PrimaryButton(
                lable: "Send Link",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await ApiService().forgotPassword(context, data: data());
                  }
                  //  Navigator.pushNamed(context, Routs.resetPassword);
                })
          ]),
        ),
      ),
    );
  }

  FormData data() {
    return FormData.fromMap({"email": controller.text});
  }

  // getData() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   userData = preferences.getString("userToken");
  //
  //   var user = VerifyOtp.fromJson(jsonDecode(userData));
  //
  //   print(user.token);
  // }
}
