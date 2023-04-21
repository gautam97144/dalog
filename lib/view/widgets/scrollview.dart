part of 'widget.dart';

class CustomScroll extends StatelessWidget {
  List<Widget> children;
  CustomScroll({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PrimaryPadding(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      )),
    ));
  }
}
