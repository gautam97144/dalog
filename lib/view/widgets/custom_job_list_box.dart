part of "widget.dart";

class JobListBox extends StatelessWidget {
  String title;
  String? amount;
  Color? color;
  TextStyle? style;
  bool? isBorder;
  String? detail;
  String? status;
  Widget? image;
  VoidCallback? onPressed;
  Widget? popupMenuButton;
  String? name;

  JobListBox(
      {Key? key,
      required this.title,
      this.amount,
      this.color,
      this.style,
      this.detail,
      this.status,
      this.image,
      this.popupMenuButton,
      this.onPressed,
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
          height: Sizes.s150.h,
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? Theme.of(context).cardColor
                  : AppColor.white,
              borderRadius: BorderRadius.circular(Sizes.s20.r)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: appText(
                      title,
                      style: AppTextStyle.headingTextTile,
                      softWrap: true,
                      maxLines: 2,
                    ),
                  ),
                  appText(amount ?? "",
                      style: AppTextStyle.headingTextTile2
                          .copyWith(color: AppColor.primaryColor)),
                  popupMenuButton ?? const SizedBox.shrink(),
                ],
              ),
              Row(children: [
                appText(status ?? "", style: AppTextStyle.greySubTitle),
                SizedBoxW10(),
                image ?? const SizedBox.shrink(),
                SizedBoxW10(),
                appText(name ?? "", style: AppTextStyle.blackSubTitle)
              ])
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
                  color: color ?? AppColor.lightPrimaryColor,
                  shape: StadiumBorder(
                      side: isBorder == true
                          ? BorderSide(
                              color: Theme.of(context).brightness ==
                                      ThemeUtils.darkTheme.brightness
                                  ? Theme.of(context).cardColor
                                  : AppColor.white,
                              width: 3)
                          : BorderSide.none)),
              child: appText(detail ?? "",
                  style: style ??
                      AppTextStyle.buttonTextStyle
                          .copyWith(color: AppColor.primaryColor)),
            ),
          ),
        ),
      )
    ]);
  }
}
