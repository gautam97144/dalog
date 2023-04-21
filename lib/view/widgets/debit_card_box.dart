part of "widget.dart";

class DebitCardBox extends StatelessWidget {
  DebitCardBox({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.trailing,
    required this.leading,
    this.width,
  }) : super(key: key);
  Widget leading;
  String trailing;
  String title;
  String subTitle;
  double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Sizes.s10.w, vertical: Sizes.s5.h),
      //alignment: Alignment.center,
      //margin: const EdgeInsets.only(left: 5),
      height: Sizes.s60.h,
      width: width ?? ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Sizes.s10.r),
          color: Theme.of(context).dialogBackgroundColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 4),
              blurRadius: 7,
              spreadRadius: 2,
              color: Theme.of(context).shadowColor,
            ), // BoxShadow(
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leading,
            ],
          ),
          SizedBox(
            width: Sizes.s5.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              appText(title,
                  style: AppTextStyle.blackSubTitle.copyWith(
                      fontWeight: FontWeight.w700, fontSize: Sizes.s14.sp)),
              appText(subTitle,
                  style: AppTextStyle.greySubTitle
                      .copyWith(fontSize: Sizes.s12.sp))
            ],
          ),
          const Expanded(child: SizedBox()),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              appText(trailing,
                  style: AppTextStyle.greySubTitle
                      .copyWith(fontSize: Sizes.s12.sp))
            ],
          )
        ],
      ),
    );
  }

  static void debitCardSelection(int index) {
    for (DebitCardData element in debitCard.value) {
      element.isSelected = false;
    }
    debitCard.value[index].isSelected = true;

    debitCard.notifyListeners();
  }
}
