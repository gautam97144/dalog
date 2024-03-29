part of '../widget.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // titleSpacing: 10,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColor.red,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SecondaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  Widget? leading;
  Widget? action;
  double? elevation;
  bool? isLeading;

  SecondaryAppBar(
      {Key? key,
      this.title,
      this.action,
      this.isLeading = true,
      this.elevation,
      this.leading})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _SecondaryAppBarState createState() => _SecondaryAppBarState();
}

class _SecondaryAppBarState extends State<SecondaryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        // backgroundColor: widget.color ?? Colors.white,
        elevation: widget.elevation,
        centerTitle: true,
        title: appText(
          widget.title ?? "",
          style: AppTextStyle.appBarTextTitle,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(child: widget.action),
          )
        ],
        leading: widget.isLeading == true
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: AppColor.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : const SizedBox.shrink());
  }
}

class TabAppBar extends StatefulWidget implements PreferredSizeWidget {
  String? title;
  Widget? leading;
  Widget? action;
  VoidCallback? onPressed;
  VoidCallback? onTap;
  double? elevation;
  PreferredSizeWidget? bottom;
  TabAppBar(
      {Key? key,
      this.title,
      required this.action,
      this.leading,
      this.bottom,
      this.onTap,
      this.elevation,
      this.onPressed})
      : preferredSize = Size.fromHeight(ScreenUtil().screenWidth * .38),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _TabAppBarState createState() => _TabAppBarState();
}

class _TabAppBarState extends State<TabAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: widget.elevation,
      shadowColor: Theme.of(context).shadowColor.withOpacity(1),
      title: appText(widget.title ?? "", style: AppTextStyle.appBarTextTitle),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
              onTap: widget.onPressed, child: Center(child: widget.action)),
        )
      ],
      leading: InkWell(
        highlightColor: Colors.transparent,
        onTap: widget.onTap,
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(child: widget.leading)),
      ),
      bottom: widget.bottom,
    );
  }
}

class OpenJobAppBar extends StatefulWidget implements PreferredSizeWidget {
  Widget? title;
  Widget? leading;
  Widget? action;
  VoidCallback? onPressed;
  double? elevation;
  double? leadingWidth;
  PreferredSizeWidget? bottom;
  OpenJobAppBar(
      {Key? key,
      this.title,
      required this.action,
      this.leading,
      this.bottom,
      this.leadingWidth,
      this.elevation,
      this.onPressed})
      : preferredSize = Size.fromHeight(ScreenUtil().screenWidth * .4),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _OpenJobAppBarState createState() => _OpenJobAppBarState();
}

class _OpenJobAppBarState extends State<OpenJobAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: widget.leadingWidth,
      elevation: widget.elevation,
      shadowColor: Theme.of(context).shadowColor.withOpacity(1),
      title: widget.title,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: GestureDetector(
              onTap: widget.onPressed, child: Center(child: widget.action)),
        )
      ],
      leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(child: widget.leading)),
      bottom: widget.bottom,
    );
  }
}
