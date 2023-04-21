part of "widget.dart";

class CustomBottomSheet {
  static showBottomSheet(BuildContext context, List<Widget> children,
      {double? height, Color? color}) {
    //  Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius))),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness ==
                          ThemeUtils.darkTheme.brightness
                      ? AppColor.darkThemePrimaryColor
                      : color ?? AppColor.white,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      topLeft: Radius.circular(borderRadius))),
              height: height ?? ScreenUtil().screenHeight * 0.6,
              child: PrimaryPadding(
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: children)),
              ),
            ),
          );
        });
  }
}
