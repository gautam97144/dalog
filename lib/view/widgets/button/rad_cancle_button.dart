part of '../widget.dart';

class CancelButton extends StatelessWidget {
  final String lable;
  final VoidCallback onPressed;
  final double? height;
  const CancelButton(
      {Key? key, required this.lable, required this.onPressed, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: height ?? ScreenUtil().setHeight(50),
        minWidth: double.infinity,
        shape: const StadiumBorder(),

        // RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(primaryButtonRadius)),
        //
        color: AppColor.red,
        elevation: 3,
        onPressed: onPressed,
        child: appText(lable, style: AppTextStyle.buttonTextStyle));
  }
}
