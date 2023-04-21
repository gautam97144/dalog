import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Scaffold(
        appBar: SecondaryAppBar(
          title: "Help & Support",
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomSizedBox(),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ques.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Sizes.s5.h, horizontal: Sizes.s10.w),
                        child: appText(ques[index].question.toString(),
                            softWrap: true, style: AppTextStyle.greySubTitle),
                      ),
                      Divider(
                        thickness: 2,
                        color: Theme.of(context).dividerColor,
                      )
                    ],
                  );
                },
              ),
              cusromerCareSection(context)
            ],
          ),
        ),
      ),
    ]);
  }

  Widget cusromerCareSection(BuildContext context) {
    return Container(
      height: ScreenUtil().screenWidth / .95,
      padding:
          EdgeInsets.symmetric(horizontal: Sizes.s16.w, vertical: Sizes.s10.h),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? const Color(0xff0C282E)
              : AppColor.primaryColor,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBoxH14(),
            appText("Contact Customer Care",
                style: AppTextStyle.headingTextTile2
                    .copyWith(color: AppColor.white)),
            SizedBoxH10(),
            PrimaryTextField(
                hintText: "Your name",
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.darkPrimaryColor),
            PrimaryTextField(
                hintText: "Email Address",
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.darkPrimaryColor),
            SecondaryTextField(
                hintText: "New Mobile Number",
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.darkPrimaryColor),
            PrimaryButton(
                isStyle: true,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.primaryColor
                    : AppColor.white,
                lable: "Verify",
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}

class Question {
  String? question;
  Question({this.question});
}

List<Question> ques = [
  Question(question: "How Much Will the Move Cost?"),
  Question(question: "What Method of Payment Is Required?"),
  Question(question: "Do my appliances require special servicing?"),
  Question(question: "What happens to the goods in my freezer and fridge?"),
  Question(question: "Do my appliances require special servicing?"),
  Question(question: "What happens to the goods in my freezer and fridge?")
];
