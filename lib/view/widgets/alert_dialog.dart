part of "widget.dart";

class CustomDialog {
  static dialogShow(
    BuildContext context, {
    Widget? title,
    required List<Widget> children,
  }) {
    showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 150),
        transitionBuilder:
            (BuildContext context, Animation x, Animation y, Widget? child) {
          return Transform.scale(
            scale: x.value,
            child: Opacity(
                opacity: x.value,
                child: AlertDialog(
                    title: title,
                    insetPadding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
                    content:

                        // Container(
                        //   height: 100,
                        //   width: 100,
                        // )

                        SizedBox(
                      width: ScreenUtil().screenWidth / 1.4,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: children,
                      ),
                    ))),
          );
        },
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const SizedBox.shrink();
        });
  }
}
