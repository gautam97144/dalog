part of 'utils.dart';

class ThemeUtils {
  static ThemeData get lightTheme {
    return ThemeData(
        // useMaterial3: true,
        shadowColor: Colors.grey.withOpacity(0.3),
        bottomNavigationBarTheme: ThemeUtils.lightBottomNavigationBarTheme,
        appBarTheme: ThemeUtils.lightAppBarTheme,
        fontFamily: AppFontFamily.nunitoSans,
        brightness: Brightness.light,
        cardColor: AppColor.lightGrey,
        dividerColor: AppColor.darkGrey,
        tabBarTheme: ThemeUtils.lightTabBarTheme,
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: AppColor.primaryColor),
        // primaryColor: AppColor.primaryColor,
        colorScheme: const ColorScheme.light(),
        snackBarTheme: ThemeUtils.lightSnackBarTheme,
        dialogTheme: ThemeUtils.lightDialogTheme,
        inputDecorationTheme: ThemeUtils.lightInputDecorationTheme,
        dialogBackgroundColor: AppColor.white,
        scaffoldBackgroundColor: AppColor.white);
  }

  static ThemeData get darkTheme {
    return ThemeData(
        // useMaterial3: true,
        brightness: Brightness.dark,
        shadowColor: AppColor.darkThemeScaffoldBackground,
        appBarTheme: ThemeUtils.darkAppBarTheme,
        bottomNavigationBarTheme: ThemeUtils.darkBottomNavigationBarTheme,
        colorScheme: const ColorScheme.dark(),
        snackBarTheme: ThemeUtils.darkSnackBarTheme,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.grey,
        ),
        fontFamily: AppFontFamily.nunitoSans,
        cardColor: const Color(0xff0C282E),
        dividerColor: const Color(0xff0C282E),
        tabBarTheme: ThemeUtils.darkTabBarTheme,
        dialogTheme: ThemeUtils.darkDialogTheme,
        inputDecorationTheme: ThemeUtils.darkInputDecorationTheme,
        dialogBackgroundColor: const Color(0xff0C282E),
        scaffoldBackgroundColor: AppColor.darkThemeScaffoldBackground);
  }

  //0C282E

  static DialogTheme get lightDialogTheme {
    return DialogTheme(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
  }

  static DialogTheme get darkDialogTheme {
    return DialogTheme(
        backgroundColor: const Color(0xff0C282E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)));
  }

  static AppBarTheme get lightAppBarTheme {
    return const AppBarTheme(
      color: AppColor.white,
      //elevation: 2,
      shadowColor: AppColor.lightGrey,
      foregroundColor: AppColor.black,
      // titleTextStyle: AppTextStyle.lightAppBarTextTitle
    );
  }

  static AppBarTheme get darkAppBarTheme {
    return const AppBarTheme(
      //  elevation: 2,
      color: AppColor.darkThemeScaffoldBackground,
      shadowColor: AppColor.black,
      //   titleTextStyle: AppTextStyle.darkAppBArTextTitle
    );
  }

  static SnackBarThemeData get lightSnackBarTheme {
    return const SnackBarThemeData(behavior: SnackBarBehavior.floating);
  }

  static SnackBarThemeData get darkSnackBarTheme {
    return const SnackBarThemeData(behavior: SnackBarBehavior.floating);
  }

  static BottomNavigationBarThemeData get lightBottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      elevation: 10,
      backgroundColor: AppColor.white,
      selectedItemColor: AppColor.primaryColor,
      unselectedItemColor: AppColor.grey,
      selectedLabelStyle:
          AppTextStyle.greySubTitle.copyWith(fontWeight: FontWeight.w700),
      unselectedLabelStyle:
          AppTextStyle.greySubTitle.copyWith(fontWeight: FontWeight.w700),
      type: BottomNavigationBarType.fixed,
    );
  }

  static BottomNavigationBarThemeData get darkBottomNavigationBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: const Color(0xff0C282E),
      unselectedItemColor: AppColor.grey,
      selectedItemColor: AppColor.primaryColor,
      unselectedLabelStyle:
          AppTextStyle.greySubTitle.copyWith(fontWeight: FontWeight.w700),
      selectedLabelStyle:
          AppTextStyle.greySubTitle.copyWith(fontWeight: FontWeight.w700),
    );
  }

  static InputDecorationTheme get lightInputDecorationTheme {
    return InputDecorationTheme(
        filled: true,
        fillColor: AppColor.lightGrey,
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }

  static InputDecorationTheme get darkInputDecorationTheme {
    return const InputDecorationTheme(
        filled: true, fillColor: AppColor.darkThemeTextField);
  }

  static TabBarTheme get lightTabBarTheme {
    return TabBarTheme(
      labelColor: AppColor.red,
      labelStyle: AppTextStyle.redTextStyle,
      unselectedLabelColor: AppColor.unSelectedTabBarColor,
      unselectedLabelStyle: AppTextStyle.greySubTitle,
      indicator: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(50)),
    );
  }

  static TabBarTheme get darkTabBarTheme {
    return TabBarTheme(
      labelColor: AppColor.red,
      labelStyle: AppTextStyle.redTextStyle,
      unselectedLabelColor: AppColor.unSelectedTabBarColor,
      unselectedLabelStyle: AppTextStyle.greySubTitle,
      indicator: BoxDecoration(
          color: AppColor.darkThemeScaffoldBackground,
          borderRadius: BorderRadius.circular(50)),
    );
  }
}
