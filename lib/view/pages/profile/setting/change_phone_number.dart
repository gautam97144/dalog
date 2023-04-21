import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../../../../routs/app_routs.dart';

class ChangePhoneNumber extends StatelessWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Change Phone Number",
      ),
      body: CustomScroll(
        children: [
          CustomSizedBox(),
          Row(children: [
            const Flexible(
              child: PrimaryTextField(
                readOnly: true,
                hintText: "+91",
                suffix: Icon(Icons.keyboard_arrow_down_outlined),
              ),
            ),
            SizedBoxW8(),
            const Flexible(
              flex: 2,
              child: PrimaryTextField(
                hintText: "Old Mobile Number",
              ),
            ),
          ]),
          Row(
            children: [
              const Flexible(
                child: PrimaryTextField(
                  readOnly: true,
                  hintText: "+91",
                  suffix: Icon(Icons.keyboard_arrow_down_outlined),
                ),
              ),
              SizedBoxW8(),
              const Flexible(
                flex: 2,
                child: PrimaryTextField(
                  hintText: "New Mobile Number",
                ),
              ),
            ],
          ),
          SizedBoxH28(),
          appText(
              "**A verification will be sent to your phone to confirm your new number**",
              softWrap: true,
              textAlign: TextAlign.center,
              style: AppTextStyle.blackSubTitle.copyWith(
                  color: Theme.of(context).brightness ==
                          ThemeUtils.darkTheme.brightness
                      ? AppColor.darkTextColor
                      : AppColor.black)),
          SizedBoxH28(),
          PrimaryButton(
              lable: "Verification Code",
              onPressed: () {
                Navigator.pushNamed(context, Routs.otp);
              })
        ],
      ),
    );
  }
}
