part of "extension.dart";

extension ColorSchemeExtension on ColorScheme {
  Color get warning => this.brightness == Brightness.light
      ? AppColor.lightGrey
      : AppColor.darkThemeScaffoldBackground;
}
