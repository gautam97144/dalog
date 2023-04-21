import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllDialogWidget {
  AllDialogWidget._();

  static Widget deleteListing(
      {String? heading,
      String? data,
      Widget? title,
      Widget? button,
      String? endTitle}) {
    return SizedBox(
      width: ScreenUtil().screenWidth / 1.4,
      child: Column(
        children: [
          title!,
          SizedBoxH14(),
          appText(heading!, style: AppTextStyle.headline2),
          SizedBoxH10(),
          appText(data!,
              textAlign: TextAlign.center,
              style: AppTextStyle.blackSubTitle,
              softWrap: true),
          SizedBoxH10(),
          button!,
          SizedBoxH10(),
          appText(endTitle!, style: AppTextStyle.redTextStyle)
        ],
      ),
    );
  }
}
