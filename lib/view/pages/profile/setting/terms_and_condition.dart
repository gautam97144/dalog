import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Terms & Conditions",
      ),
      body: CustomScroll(
        children: [
          CustomSizedBox(),
          appText("terms And Condition one",
              style: AppTextStyle.greySubTitle, softWrap: true),
          CustomSizedBox(),
          appText("terms And Condition two",
              style: AppTextStyle.greySubTitle, softWrap: true),
          CustomSizedBox(),
          appText("title", style: AppTextStyle.headline2),
          SizedBoxH10(),
          appText("terms And Condition third",
              style: AppTextStyle.greySubTitle, softWrap: true),
          SizedBoxH10(),
        ],
      ),
    );
  }
}
