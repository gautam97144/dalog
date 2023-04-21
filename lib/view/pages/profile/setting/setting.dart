import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/models/setting.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Setting",
      ),
      body: CustomScroll(
        children: [
          CustomSizedBox(),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: profileSetting.length,
              itemBuilder: (context, index) {
                return box(index, context);
              }),
        ],
      ),
    );
  }

  Widget box(int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Sizes.s10.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, profileSetting[index].route.toString());
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
          height: Sizes.s60.h,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(2, 4),
                  blurRadius: 7,
                  spreadRadius: 2,
                  color: Theme.of(context).shadowColor,
                ),
              ],
              borderRadius: BorderRadius.circular(Sizes.s10.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText(profileSetting[index].name.toString(),
                  style: AppTextStyle.headline2),
              const Icon(Icons.arrow_forward_ios_outlined)
            ],
          ),
        ),
      ),
    );
  }
}
