import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/models/driver_profile.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../../../../utils/utils.dart';

class SearchDriverList extends StatelessWidget {
  SearchDriverList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor:
          Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.darkThemeScaffoldBackground
              : AppColor.lightGrey,
      body: CustomScroll(children: [
        CustomSizedBox(),
        appText("Recent search", style: AppTextStyle.headingTextTile),
        appText("Drivers available near you", style: AppTextStyle.greySubTitle),
        CustomSizedBox(),
        listOfDriverProfile()
      ]),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: Sizes.s90.h,
      title: TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            fillColor: Theme.of(context).cardColor,
            hintText: 'Find a Driver',
            hintStyle: const TextStyle(
                fontSize: Sizes.s16,
                color: AppColor.driverProfileSubtitleColor),
            prefixIcon: const Icon(
              Icons.search,
              color: AppColor.driverProfileSubtitleColor,
            ),
            suffixIcon: Icon(Icons.clear,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.white
                    : AppColor.black)),
      ),
    );
  }

  Widget listOfDriverProfile() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: driverProfile.length,
      itemBuilder: (context, index) {
        return SecondaryDriverProfileBox(
          image: driverProfile[index].image,
          driverName: driverProfile[index].name,
          //    vahicalName: driverProfile[index].,
        );
      },
    );
  }
}
