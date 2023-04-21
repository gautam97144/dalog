import 'package:dalog_distribution/helper/shared_preferance.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../constant/constant.dart';
import '../../../provider/user_id_provider.dart';
import '../../../routs/app_routs.dart';
import '../../../utils/utils.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatToNext();
  }

  Future<void> _navigatToNext() async {
    String? userId1 =  await Preferances.prefGetString("userid",'');
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if(userId1!.isNotEmpty){
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.bottomNavigation, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(
            context, Routs.chooseLanguage, (route) => false);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    print(ScreenUtil().uiSize.width);
    return Scaffold(
        backgroundColor:
            Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                ? AppColor.primaryColor
                : Colors.white,
        body: Center(
          child: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? SvgPicture.asset(
                  AppAsset.darkSplash,
                  height: Sizes.s200.h,
                  width: Sizes.s200.h,
                )
              : Image.asset(
                  AppAsset.splash,
                  height: Sizes.s200.h,
                  width: Sizes.s200.h,
                  filterQuality: FilterQuality.high,
                ),
        ));
  }

  static Future permissionHanDle(int? index) async {
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.location,
      Permission.notification
    ].request();
    if (status[Permission.camera]!.isGranted ||
        status[Permission.storage]!.isGranted ||
        status[Permission.notification]!.isGranted) {
      if (Preferances.getString("user") == null) {}
    }

    return status;
  }
}
