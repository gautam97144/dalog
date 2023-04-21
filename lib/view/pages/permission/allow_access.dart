import 'dart:io';

import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/helper/shared_preferance.dart';
import 'package:dalog_distribution/provider/allow_access_provider.dart';
import 'package:dalog_distribution/routs/app_routs.dart';
import 'package:dalog_distribution/services/function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/constant.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';

class AllowAccess extends StatelessWidget {
  const AllowAccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PrimaryPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: Sizes.s30,
              ),
              appText(
                "Allow Access",
                style: AppTextStyle.headline1,
              ),
              appText("Please check the following permissions",
                  style: AppTextStyle.greySubTitle),
              const SizedBox(
                height: Sizes.s50,
              ),
              Expanded(
                child: Consumer<AllowAccessProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.getAccessData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: [
                          InkWell(
                            onTap: () {
                              value.allow(index);
                            },
                            child: CommonCard(
                              trailing: value.getAccessData[index].trailing ==
                                      true
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
                                            color: Theme.of(context)
                                                        .brightness ==
                                                    ThemeUtils
                                                        .darkTheme.brightness
                                                ? AppColor
                                                    .chooseLanguageOuterCircle
                                                : AppColor.darkGrey,
                                          ),
                                          shape: BoxShape.circle),
                                    ),
                              leading: SvgPicture.asset(
                                value.getAccessData[index].leading.toString(),
                                width: Sizes.s40.h,
                                height: Sizes.s40.h,
                              ),
                              boldTitle: Expanded(
                                child: appText(
                                    value.getAccessData[index].boldTitle
                                        .toString(),
                                    softWrap: true,
                                    maxLines: 2),
                              ),
                              title: Expanded(
                                child: appText(
                                    value.getAccessData[index].title.toString(),
                                    softWrap: true,
                                    maxLines: 2),
                              ),
                              // onPressed: value.getAccessData[index].onPressed,
                            ),
                          ),
                          SizedBox(
                            height: Sizes.s8.h,
                          )
                        ]);
                      },
                    );
                  },
                ),
              ),
              PrimaryButton(
                  lable: 'Allow Access',
                  onPressed: () {
                    bool isGrant = context
                        .read()<AllowAccessProvider>()
                        .isAllowAllPermission();

                    if (isGrant) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routs.login, (route) => false);
                    } else {
                      CommonFunctions.toast("Please Allow all permission");
                    }

                    // Navigator.pushNamed(context, Routs.login);
                  }),
              const SizedBox(
                height: Sizes.s10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                TextButton(
                    onPressed: () {
                      CustomDialog.dialogShow(context,
                          children: [popUpContent(context)]);
                    },
                    child: appText("Deny", style: AppTextStyle.redTextStyle))
              ]),
              const SizedBox(
                height: Sizes.s10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget popUpContent(BuildContext context) {
    return Column(
      children: [
        appText("allow Access popup",
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTextStyle.headline2),
        SizedBoxH28(),
        PrimaryButton(
            lable: "Allow Access",
            onPressed: () async {
              bool isGrant =
                  context.read<AllowAccessProvider>().isAllowAllPermission();

              if (isGrant) {
                Navigator.pushNamedAndRemoveUntil(
                    context, Routs.login, (route) => false);
              } else {
                Navigator.of(context).pop();
                CommonFunctions.toast("Please Allow all permission");
              }

              // String? userid = await Preferances.getString("userid");
              //
              // if (userid == null) {
              //   Navigator.pushNamed(context, Routs.login);
              // } else {
              //   Navigator.pushNamed(context, Routs.bottomNavigation);
              // }
            }),
        SizedBoxH14(),
        InkWell(
            onTap: () {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            },
            child: appText("Deny", style: AppTextStyle.redTextStyle))
      ],
    );
  }

  void notificationPermission() {}
}
