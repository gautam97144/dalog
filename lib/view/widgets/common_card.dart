part of "widget.dart";

class CommonCard extends StatelessWidget {
  Widget title;
  Widget? leading;
  Widget? trailing;
  Widget? boldTitle;
  VoidCallback? onPressed;

  CommonCard(
      {Key? key,
      required this.title,
      this.trailing,
      this.leading,
      this.boldTitle,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.s12),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: Sizes.s80.h,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: trailing == null
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            leading ?? const SizedBox.shrink(),
            SizedBox(
              width: Sizes.s16.w,
            ),
            boldTitle ?? const SizedBox.shrink(),
            title,
            trailing ?? const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
