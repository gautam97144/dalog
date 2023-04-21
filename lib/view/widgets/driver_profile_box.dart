part of 'widget.dart';

class DriverProfileBox extends StatelessWidget {
  final Color? color;
  final bool? isBorder;
  final String? status;
  final String? reviewCount;
  final String? review;
  final String? deliveryCount;
  final String? delivery;
  final TextStyle? style;
  final String? image;
  final String? date;
  final VoidCallback? onPressed;
  final String? name;
  final String? detail;

  const DriverProfileBox(
      {Key? key,
      this.color,
      this.status,
      this.style,
      this.deliveryCount,
      this.delivery,
      this.review,
      this.onPressed,
      this.reviewCount,
      this.image,
      this.date,
      this.detail,
      this.name,
      this.isBorder = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: EdgeInsets.symmetric(
            vertical: Sizes.s20.w, horizontal: Sizes.s30.w),
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.s20.w, vertical: Sizes.s20.h),
          height: ScreenUtil().screenWidth / 2,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Theme.of(context).brightness ==
                          ThemeUtils.darkTheme.brightness
                      ? AppColor.darkBorderColor
                      : AppColor.white,
                  width: 3),
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? const Color(0xff0C282E)
                  : AppColor.lightGrey,
              borderRadius: BorderRadius.circular(Sizes.s20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Sizes.s50.h,
                    width: Sizes.s50.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(image!)),
                        borderRadius: BorderRadius.circular(borderRadius)),
                  ),
                  SizedBoxW10(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appText(name!, style: AppTextStyle.appBarTextTitle),
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAsset.stearing,
                            height: Sizes.s20.h,
                            width: Sizes.s20.w,
                            color: AppColor.driverProfileSubtitleColor,
                          ),
                          SizedBoxW8(),
                          appText("Con Air Cargo Van",
                              maxLines: 1,
                              isTextOverflow: true,
                              style: AppTextStyle.alertSubtitle.copyWith(
                                  color: AppColor.driverProfileSubtitleColor))
                        ],
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    height: Sizes.s50.h,
                    width: Sizes.s50.w,
                    decoration: BoxDecoration(
                        color: Theme.of(context).brightness ==
                                ThemeUtils.darkTheme.brightness
                            ? AppColor.darkThemeScaffoldBackground
                            : AppColor.white,
                        borderRadius: BorderRadius.circular(borderRadius)),
                    child: const Icon(Icons.favorite_outline_rounded),
                  )
                ],
              ),
              Divider(
                thickness: 2,
                color: Theme.of(context).dividerColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      appText(deliveryCount!,
                          style: AppTextStyle.blackSubTitle
                              .copyWith(fontWeight: FontWeight.w700)),
                      appText("Total Delivery",
                          style: AppTextStyle.alertSubtitle.copyWith(
                              color: AppColor.driverProfileSubtitleColor))
                    ],
                  ),
                  Column(
                    children: [
                      appText(reviewCount!,
                          style: AppTextStyle.blackSubTitle
                              .copyWith(fontWeight: FontWeight.w700)),
                      appText("50 review",
                          style: AppTextStyle.alertSubtitle.copyWith(
                              color: AppColor.driverProfileSubtitleColor))
                    ],
                  ),
                  Column(
                    children: [
                      appText(date!,
                          style: AppTextStyle.blackSubTitle
                              .copyWith(fontWeight: FontWeight.w700)),
                      appText("Joined",
                          style: AppTextStyle.alertSubtitle.copyWith(
                              color: AppColor.driverProfileSubtitleColor))
                    ],
                  )
                ],
              ),
              // Column(
              //   children: [],
              // ),
              // Column(
              //   children: [],
              // )
            ],
          ),
        ),
      ),
      Positioned.fill(
        left: Sizes.s50.w,
        right: Sizes.s50.w,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: onPressed ?? null,
            child: Container(
              alignment: Alignment.center,
              height: Sizes.s50.h,
              //  width: ScreenUtil().screenWidth,
              decoration: ShapeDecoration(
                  color: AppColor.primaryColor,
                  shape: StadiumBorder(
                      side: isBorder == true
                          ? BorderSide(
                              color: Theme.of(context).brightness ==
                                      ThemeUtils.darkTheme.brightness
                                  ? Theme.of(context).cardColor
                                  : AppColor.white,
                              width: 3)
                          : BorderSide.none)),
              child: appText("Driver Profile",
                  style: AppTextStyle.buttonTextStyle),
            ),
          ),
        ),
      )
    ]);
  }
}
