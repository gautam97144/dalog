import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../helper/shared_preferance.dart';
import '../../../../routs/app_routs.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  final List<UserProfile> _userProfile = [
    UserProfile(
        name: "Fav. Drivers", icon: AppAsset.stearing, onPressed: Routs.driver),
    UserProfile(
        name: "Notifications",
        icon: AppAsset.bell,
        onPressed: Routs.notification),
    UserProfile(
        name: "Payment Method",
        icon: AppAsset.paymentMethod,
        onPressed: Routs.paymentMethod),
    UserProfile(
        name: "Settings", icon: AppAsset.setting, onPressed: Routs.setting)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.s10.h, horizontal: ScreenUtil().screenWidth / 3.5),
        child: logoutButton(context),
        // verticalPadding: Sizes.s10.h,
      ),
      appBar: appBar(context),
      backgroundColor:
          Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.darkThemeScaffoldBackground
              : AppColor.primaryColor,
      body: CustomScroll(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBoxH28(),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CircleAvatar(
                  backgroundColor: AppColor.darkPrimaryColor,
                  radius: Sizes.s76.r,
                  child: CircleAvatar(
                    backgroundImage:
                        const AssetImage(AppAsset.driverProfilePicture),
                    radius: Sizes.s73.r,
                  ),
                ),
              ]),
              appText("Chris Gayle",
                  style:
                      AppTextStyle.headline1.copyWith(color: AppColor.white)),
              appText("chrisgayle333@gmail.com",
                  style: AppTextStyle.buttonTextStyle),
              SizedBoxH28(),
              GridView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  cacheExtent: 30,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _userProfile.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 16 / 9,
                      crossAxisSpacing: Sizes.s10.h,
                      mainAxisSpacing: Sizes.s10.h),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, _userProfile[index].onPressed.toString());
                      },
                      child: box(context,
                          title: _userProfile[index].name.toString(),
                          icon: _userProfile[index].icon.toString()),
                    );
                  }),
              //Spacer(),

              SizedBoxH28(),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Center(
          child: appText("v 1.2",
              style: AppTextStyle.redTextStyle
                  .copyWith(color: AppColor.white.withOpacity(.5))),
        ),
      ),
      elevation: 0,
      backgroundColor:
          Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.darkThemeScaffoldBackground
              : AppColor.primaryColor,
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
              padding: const EdgeInsets.all(10), child: clearButton(context)),
        )
      ],
    );
  }

  Widget clearButton(BuildContext context) {
    return CircleAvatar(
      backgroundColor:
          Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? Color(0xff0C282E)
              : AppColor.white,
      radius: Sizes.s16.r,
      child: Icon(
        Icons.clear,
        color: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
            ? AppColor.white
            : AppColor.primaryColor,
      ),
    );
  }

  Widget box(BuildContext context,
      {VoidCallback? onPressed, required String icon, required String title}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        //width: ScreenUtil().screenWidth / 2,
        // height: ScreenUtil().screenWidth / 3,
        decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                    ? const Color(0xff0C282E)
                    : AppColor.darkPrimaryColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              height: Sizes.s24.h,
              width: Sizes.s24.w,
            ),
            SizedBoxH10(),
            appText(title,
                style: AppTextStyle.headline2.copyWith(color: AppColor.white))
          ],
        ),
      ),
    );
  }

  Widget logoutButton(BuildContext context) {
    return MaterialButton(
        minWidth: ScreenUtil().screenWidth / 4,
        height: ScreenUtil().setHeight(Sizes.s50.h),
        shape: const StadiumBorder(),
        color: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
            ? AppColor.primaryColor
            : AppColor.white,
        onPressed: () async {
          await Preferances.removeStoredData("userid");
          CustomDialog.dialogShow(context, children: [logOutContent(context)]);
        },
        child: appText("Logout",
            style: AppTextStyle.buttonTextStyle.copyWith(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.white
                  : AppColor.red,
            )));
  }

  Widget logOutContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAsset.logout,
          height: Sizes.s30.h,
          width: Sizes.s30.w,
        ),
        SizedBoxH10(),
        appText("Logout", style: AppTextStyle.headline2),
        SizedBoxH10(),
        appText("Are you sure you want to logout from Dalog Distribution?",
            softWrap: true,
            textAlign: TextAlign.center,
            style: AppTextStyle.alertSubtitle),
        SizedBoxH10(),
        PrimaryButton(
            lable: "Logout",
            onPressed: () {
              Preferances.removeStoredData("user").whenComplete(() =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, Routs.login, (route) => false));
            }),
        SizedBoxH10(),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: appText("Cancel", style: AppTextStyle.redTextStyle))
      ],
    );
  }
}

class UserProfile {
  String? name;
  String? icon;
  String? onPressed;

  UserProfile({this.name, this.icon, this.onPressed});
}
