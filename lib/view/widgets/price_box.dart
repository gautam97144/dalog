part of 'widget.dart';

class PriceBox extends StatelessWidget {
  String? title;
  bool isSuffixIcon;
  PriceBox({Key? key, this.title, this.isSuffixIcon = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(isSuffixIcon);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
        width: double.infinity,
        height: Sizes.s50.h,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          appText(title ?? "",
              style: AppTextStyle.blackSubTitle.copyWith(
                  fontWeight: FontWeight.w700, fontSize: Sizes.s14.sp)),
          !isSuffixIcon
              ? const SizedBox.shrink()
              : const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColor.primaryColor,
                )
        ]));
  }
}
