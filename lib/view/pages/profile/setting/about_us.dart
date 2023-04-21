import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "AboutUs",
      ),
      body: CustomScroll(
        children: [
          CustomSizedBox(),
          appText("Our Mission", style: AppTextStyle.headingTextTile),
          appText('''We are working like crazy to put together the
most awesome innovative App that connects people together ANYTIME, ANYWHERE, so you can pickup that ANYTHING you need for that ANY DESTINATION you want it! High Five! Celebration Nation!''',
              textAlign: TextAlign.start,
              softWrap: true,
              style: AppTextStyle.greySubTitle),
          SizedBoxH14(),
          image(image: AppAsset.luggage),
          SizedBoxH28(),
          appText("Dalog Dependability", style: AppTextStyle.headingTextTile),
          appText('''We at dalog are dedicated to getting the 
job done! We are making sure WHATEVER
we deliver is done with care and dedication
to get that SOMETHING to that SOMEONE
as fast as humanly possible! And as safe as
possible! It’s all about Team Work! Kudos to
the Dude’s and Dudette’s that make up Team
Dalog! Making a difference one delivery at
a time!''', style: AppTextStyle.greySubTitle),
          SizedBoxH14(),
          image(image: AppAsset.box),
          SizedBoxH28(),
          appText("Performance", style: AppTextStyle.headingTextTile),
          appText(
              "Dalog is always driving towards better ways to improve our delivery services. We make note of what works and what doesn’t so we can keep getting better at what we do! The goal is to make your life better by providing an easy and reliable way to get your deliveries where you need them, when you need them, and at a cost that doesn’t break the bank!.Simple.",
              softWrap: true,
              style: AppTextStyle.greySubTitle),
          SizedBoxH10()
        ],
      ),
    );
  }

  Widget image({String? image}) {
    return Container(
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenWidth / 2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(fit: BoxFit.fill, image: AssetImage(image!))),
    );
  }
}
