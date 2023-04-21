part of "widget.dart";

class CustomHeader extends StatelessWidget {
  final String header;
  final String subTitle;
  final Widget children;
  const CustomHeader(
      {Key? key,
      required this.header,
      required this.subTitle,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PrimaryPadding(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: Sizes.s30,
              ),
              appText(
                header,
                style: AppTextStyle.headline1,
              ),
              appText(subTitle,
                  style: AppTextStyle.greySubTitle, softWrap: true),
              const SizedBox(
                height: Sizes.s30,
              ),
              children,
            ],
          ),
        ),
      ),
    );
  }
}
