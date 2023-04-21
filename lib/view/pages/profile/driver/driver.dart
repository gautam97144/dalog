import 'package:dalog_distribution/models/driver_profile.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constant/constant.dart';
import '../../../../routs/app_routs.dart';
import '../../../../utils/utils.dart';

class Driver extends StatefulWidget {
  const Driver({Key? key}) : super(key: key);

  @override
  State<Driver> createState() => _DriverState();
}

class _DriverState extends State<Driver> with SingleTickerProviderStateMixin {
  TabController? tabController;
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController =
        TabController(length: 2, vsync: this, animationDuration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.darkThemeScaffoldBackground
              : AppColor.lightGrey,
      appBar: TabAppBar(
        onTap: () => Navigator.pop(context),
        leading: const Icon(
          Icons.arrow_back_ios_outlined,
          color: AppColor.red,
        ),
        title: "Drivers",
        action: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routs.searchDriver),
                icon: const Icon(Icons.search)),
            // SvgPicture.asset(
            //   AppAsset.search,
            //   height: Sizes.s30.h,
            //   width: Sizes.s30.w,
            // ),
            SizedBoxW8(),
            InkWell(
              highlightColor: Colors.transparent,
              onTap: () => Navigator.pushNamed(context, Routs.filter),
              child: SvgPicture.asset(
                AppAsset.driverFilter,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.white
                    : AppColor.black,
                height: Sizes.s20.h,
                width: Sizes.s20.w,
              ),
            )
          ],
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Sizes.s10.h, horizontal: Sizes.s10.w),
              child: Container(
                // alignment: Alignment.center,
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s5.w, vertical: Sizes.s5.h),
                width: ScreenUtil().screenWidth,
                height: 60,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: TabBar(
                  controller: tabController,
                  onTap: (index) {
                    selectedIndex.value = index;
                    print(selectedIndex.value);
                  },
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: "All Driver",
                    ),
                    Tab(
                      text: "Favourite",
                    ),
                  ],
                ),
              ),
            )),
      ),
      body: TabBarView(
        controller: tabController,
        children: [listOfDriver(), listOfDriver()],
      ),
    );
  }

  Widget listOfDriver() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: driverProfile.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: Sizes.s10.h),
            child: DriverProfileBox(
              onPressed: () =>
                  Navigator.pushNamed(context, Routs.driverProfile),
              deliveryCount: driverProfile[index].deliveryCount,
              name: driverProfile[index].name.toString(),
              date: driverProfile[index].date.toString(),
              reviewCount: driverProfile[index].reviewCount.toString(),
              image: driverProfile[index].image.toString(),
            ),
          );
        });
  }
}
