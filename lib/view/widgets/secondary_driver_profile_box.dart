part of 'widget.dart';

class SecondaryDriverProfileBox extends StatelessWidget {
  SecondaryDriverProfileBox(
      {Key? key, this.image, this.driverName, this.vahicalName})
      : super(key: key);

  String? image;
  String? driverName;
  String? vahicalName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.s10.h),
      child: Container(
        //height: Sizes.s50.h,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color:
                Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemePrimaryColor
                    : AppColor.lightGrey,
            border: Border.all(
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkBorderColor
                    : AppColor.white,
                width: 3),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.s16.w, vertical: Sizes.s16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Sizes.s50.h,
                height: Sizes.s50.w,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image!))),
              ),
              SizedBoxW8(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(driverName!,
                      style: AppTextStyle.headline2.copyWith(
                          color: Theme.of(context).brightness ==
                                  ThemeUtils.darkTheme.brightness
                              ? AppColor.darkTextColor
                              : AppColor.black)),
                  Row(children: [
                    SvgPicture.asset(AppAsset.stearing,
                        height: Sizes.s20.h,
                        width: Sizes.s20.w,
                        color: Theme.of(context).brightness ==
                                ThemeUtils.darkTheme.brightness
                            ? const Color(0xff616467)
                            : AppColor.driverProfileSubtitleColor),
                    SizedBoxW8(),
                    appText(
                      "Con Air Cargo Van",
                      maxLines: 1,
                      isTextOverflow: true,
                      style: AppTextStyle.alertSubtitle.copyWith(
                          color: Theme.of(context).brightness ==
                                  ThemeUtils.darkTheme.brightness
                              ? const Color(0xff616467)
                              : AppColor.driverProfileSubtitleColor),
                    )
                  ])
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
