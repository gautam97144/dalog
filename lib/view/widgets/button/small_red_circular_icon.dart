part of '../widget.dart';

class SmallRedCircularIcon extends StatelessWidget {
  double? raduis;
  Color? color;
  bool? isChecked;
  SmallRedCircularIcon(
      {Key? key, this.raduis, this.color, this.isChecked = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        backgroundColor: color ?? AppColor.red,
        radius: raduis ?? Sizes.s16.r,
        child: isChecked == false
            ? const Icon(
                Icons.check,
                color: AppColor.white,
              )
            : const SizedBox.shrink());
  }
}
