import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/routs/app_routs.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../provider/provider.dart';
import '../../../widgets/widget.dart';

class ChangeLanguage extends StatelessWidget {
  ChangeLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SecondaryAppBar(
          title: "Language",
        ),
        body: SafeArea(
          child: PrimaryPadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBox(),
                appText("Choose language to continue with app",
                    style: AppTextStyle.greySubTitle),
                const SizedBox(
                  height: Sizes.s30,
                ),
                Expanded(
                  child: Consumer<LanguageSelectionProvider>(
                      builder: (BuildContext context, value, Widget? child) {
                    return ListView.builder(
                      itemCount: value.getLangugeList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CommonCard(
                              onPressed: () {
                                value.update(index);
                              },
                              leading:
                                  value.getLangugeList[index].isSelected == true
                                      ? Container(
                                          width: Sizes.s28.h,
                                          height: Sizes.s28.h,
                                          decoration: const BoxDecoration(
                                              color: AppColor.white,
                                              shape: BoxShape.circle),
                                          child: const Icon(
                                            Icons.check,
                                            //size: Sizes.s8.h,
                                            color: AppColor.red,
                                          ),
                                        )
                                      : Container(
                                          width: Sizes.s28.h,
                                          height: Sizes.s28.h,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: AppColor.darkGrey,
                                              ),
                                              shape: BoxShape.circle),
                                        ),
                              title: Text(
                                  value.getLangugeList[index].title.toString(),
                                  style: AppTextStyle.headline2),
                            ),
                            SizedBox(
                              height: Sizes.s8.h,
                            ),
                          ],
                        );
                      },
                    );
                  }),
                ),
                PrimaryButton(
                    lable: "Continue",
                    onPressed: () {
                      Navigator.pushNamed(context, Routs.allowAccess);
                    }),
                SizedBox(
                  height: Sizes.s10.h,
                ),
              ],
            ),
          ),
        ));
  }
}
