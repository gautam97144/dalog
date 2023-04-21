import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constant/constant.dart';
import '../../../../models/notification_model.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        action: SvgPicture.asset(
          AppAsset.deleteBlackIcon,
          height: Sizes.s22.h,
          width: Sizes.s22.w,
          color: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.white
              : AppColor.black,
        ),
        title: "Notification",
      ),
      body: CustomScroll(children: [
        CustomSizedBox(),
        ListView.builder(
            shrinkWrap: true,
            itemCount: notificationList.length,
            itemBuilder: (context, index) => notificationData(index)),
      ]),
    );
  }

  Widget notificationData(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText(notificationList[index].title.toString(),
            style: AppTextStyle.appBarTextTitle
                .copyWith(color: AppColor.primaryColor)),
        SizedBoxH10(),
        appText(notificationList[index].subTitle.toString(),
            softWrap: true, style: AppTextStyle.headline2),
        SizedBoxH10(),
        appText(notificationList[index].date.toString(),
            style: AppTextStyle.greySubTitle),
        const Divider(
          thickness: 2,
        )
      ],
    );
  }
}
