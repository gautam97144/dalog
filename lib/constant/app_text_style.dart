import 'package:flutter/material.dart';

import 'constant.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle headline1 = TextStyle(
    fontSize: Sizes.s28,
    fontWeight: FontWeight.w900,
    //fontFamily: AppFontFamily.nunitoSans
  );

  static const TextStyle headline2 =
      TextStyle(fontSize: Sizes.s16, fontWeight: FontWeight.w700);
  static const TextStyle subTitle =
      TextStyle(fontSize: Sizes.s14, fontWeight: FontWeight.w900);

  static const TextStyle subTitle2 =
      TextStyle(fontSize: Sizes.s14, fontWeight: FontWeight.w400);
  static const TextStyle body1 =
      TextStyle(fontSize: Sizes.s12, fontWeight: FontWeight.w900);
  static const TextStyle body2 =
      TextStyle(fontSize: Sizes.s12, fontWeight: FontWeight.w400);

  static const TextStyle greySubTitle = TextStyle(
      color: AppColor.grey, fontSize: Sizes.s16, fontWeight: FontWeight.w400);
  //static TextStyle body3 = const TextStyle(fontSize: 18);

  static const TextStyle buttonTextStyle = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.bold, color: AppColor.white);
  static const TextStyle redTextStyle = TextStyle(
      fontSize: Sizes.s16, fontWeight: FontWeight.bold, color: AppColor.red);
  static const TextStyle blackSubTitle =
      TextStyle(fontSize: Sizes.s16, fontWeight: FontWeight.w400);
  static const TextStyle appBarTextTitle =
      TextStyle(fontSize: Sizes.s20, fontWeight: FontWeight.w900);

  static const TextStyle headingTextTile =
      TextStyle(fontSize: Sizes.s18, fontWeight: FontWeight.w900);

  static const TextStyle headingTextTile2 =
      TextStyle(fontSize: Sizes.s20, fontWeight: FontWeight.w900);

  static const TextStyle alertSubtitle = TextStyle(
      color: Color(0xff616467),
      fontSize: Sizes.s14,
      fontWeight: FontWeight.w900);
}
