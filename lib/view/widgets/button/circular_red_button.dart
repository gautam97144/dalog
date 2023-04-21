part of '../widget.dart';

class CircularRedButton extends StatelessWidget {
  Widget child;
  CircularRedButton({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: Sizes.s40.h,
      width: Sizes.s40.w,
      decoration: const BoxDecoration(
        color: AppColor.red,
        shape: BoxShape.circle,
      ),
      child: Center(child: child),
    );
  }
}
