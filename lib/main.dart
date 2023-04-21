import 'package:bot_toast/bot_toast.dart';
import 'package:dalog_distribution/get_it/get.dart';
import 'package:dalog_distribution/provider/allow_access_provider.dart';
import 'package:dalog_distribution/provider/drop_location_provider.dart';
import 'package:dalog_distribution/provider/image_data.dart';
import 'package:dalog_distribution/provider/pick_up_location.dart';
import 'package:dalog_distribution/provider/provider.dart';
import 'package:dalog_distribution/provider/user_id_provider.dart';
import 'package:dalog_distribution/routs/app_routs.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  GetInjectorInitializeAtOnce.init();

  runApp(EasyLocalization(
      supportedLocales: [
        Locale('en', 'GB'),
        Locale('es', 'ES'),
        Locale('fr', 'FR')
      ],
      fallbackLocale: const Locale('en', 'GB'),
      path: 'assets/translation',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageSelectionProvider>(
            create: (context) => LanguageSelectionProvider()),
        ChangeNotifierProvider<AllowAccessProvider>(
            create: (context) => AllowAccessProvider()),
        ChangeNotifierProvider<LocationProvider>(
            create: (context) => LocationProvider()),
        ChangeNotifierProvider<DropOffLocationProvider>(
            create: (context) => DropOffLocationProvider()),
        ChangeNotifierProvider<ImageData>(create: (context) => ImageData()),
        ChangeNotifierProvider<UserId>(create: (context) => UserId()),
        // ChangeNotifierProvider<ImageAdd>(create: (context) => ImageAdd())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        themeMode: ThemeMode.system,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: Routs.splash,
        onGenerateRoute: RoutGenerator.generateRoute,
        darkTheme: ThemeUtils.darkTheme,
        theme: ThemeUtils.lightTheme,
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: const _ScrollBehaviorModified(),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                ScreenUtil.init(constraints,
                    designSize:
                        Size(constraints.maxWidth, constraints.maxHeight));
                child = botToastBuilder(context, child);
                return child ?? const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}

class _ScrollBehaviorModified extends ScrollBehavior {
  const _ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
