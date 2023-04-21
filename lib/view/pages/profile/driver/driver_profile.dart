import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DriverProfileDetail extends StatefulWidget {
  const DriverProfileDetail({Key? key}) : super(key: key);

  @override
  State<DriverProfileDetail> createState() => _DriverProfileDetailState();
}

class _DriverProfileDetailState extends State<DriverProfileDetail>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  //ValueNotifier<int> selectedIndex = ValueNotifier(0);

  int selectedIndex = 0;

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
        // backgroundColor: AppColor.white,
        appBar: SecondaryAppBar(
          title: "Drivers Profile",
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s30.w),
            height: ScreenUtil().screenHeight / 2.5,
            color:
                //Theme.of(context).cardColor,
                AppColor.primaryColor,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    CircleAvatar(
                      radius: Sizes.s70.r,
                      backgroundImage: const AssetImage(AppAsset.driverPhoto),
                    ),
                    Positioned.fill(
                        child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: Sizes.s50.h,
                        width: Sizes.s50.w,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(AppAsset.car)),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColor.primaryColor, width: 3)),
                      ),
                    ))
                  ]),
                  Column(
                    children: [
                      ratingButton(
                          onPressed: () => CustomDialog.dialogShow(context,
                              title: appText("Driver Rating",
                                  style: AppTextStyle.headingTextTile),
                              children: [content()]),
                          isLikeButton: true),
                      appText('Robin Colida',
                          style: AppTextStyle.headingTextTile2
                              .copyWith(color: AppColor.white)),
                      appText("Denver (Colorado)",
                          style: AppTextStyle.subTitle
                              .copyWith(color: AppColor.white.withOpacity(.5)))
                    ],
                  )
                ],
              ),
              SizedBoxH14(),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Sizes.s20.w, vertical: Sizes.s10.h),
                height: ScreenUtil().screenWidth / 5,
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: AppColor.darkPrimaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        appText("503",
                            style: AppTextStyle.headline2
                                .copyWith(color: AppColor.white)),
                        appText("Total Deliveries",
                            style: AppTextStyle.subTitle.copyWith(
                                color: AppColor.white.withOpacity(.5)))
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.s5.h),
                      child: const VerticalDivider(
                        width: 2,
                        color: Colors.white,
                      ),
                    ),
                    Column(
                      children: [
                        appText("28 feb 2022",
                            style: AppTextStyle.headline2.copyWith(
                              color: AppColor.white,
                            )),
                        appText("joined(2.3 yr)",
                            style: AppTextStyle.subTitle.copyWith(
                                color: AppColor.white.withOpacity(.5)))
                      ],
                    )
                  ],
                ),
              )
            ]),
          ),

          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: (ScreenUtil().screenHeight / 2) - 20,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Sizes.s50.h,
                              ),
                              appText("Vehicle no: KJDD05",
                                  style: AppTextStyle.greySubTitle.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color:
                                          AppColor.filterPopUpTextColorLight)),
                              SizedBoxH14(),
                              appText("2022 Ford F-150 Pickup Truck",
                                  style: AppTextStyle.headingTextTile2),
                              SizedBoxH14(),
                              commonCard(
                                  isDownload: true,
                                  title: "License plate:",
                                  subTitle: "Exp: 22-10-2022"),
                              commonCard(
                                  title: "English, Spanish, French",
                                  subTitle: 'Speaking Languages'),
                              Row(
                                children: [
                                  Flexible(
                                      child: commonCard(
                                    image: AppAsset.tempo,
                                    isImage: true,
                                  )),
                                  SizedBoxW8(),
                                  Flexible(
                                      child: commonCard(
                                    image: AppAsset.tempo,
                                    isImage: true,
                                  ))
                                ],
                              ),
                              SizedBoxH10(),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                            child: Column(
                          children: [
                            SizedBox(
                              height: Sizes.s50.h,
                            ),
                            chatBox(),
                            SizedBoxH10(),
                            chatBox(),
                            SizedBoxH10()
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  top: -20,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      //margin: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
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
                          selectedIndex = index;
                        },
                        //indicatorPadding: EdgeInsets.zero,
                        //labelPadding: EdgeInsets.zero,
                        //padding: EdgeInsets.zero,
                        tabs: const [
                          Tab(
                            text: "About",
                          ),
                          Tab(
                            text: "Feedback",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
          // Positioned.fill(
          //     child: Container(
          //   color: AppColor.red,
          //   width: 100,
          //   height: 100,
          // )),
        ]));
  }

  Widget content() {
    return Column(
      children: [
        SizedBox(
          height: Sizes.s50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: driverRating.value.length,
            itemBuilder: (BuildContext context, int index) {
              return ValueListenableBuilder(
                valueListenable: driverRating,
                builder: (BuildContext context, value, Widget? child) {
                  return Row(children: [
                    GestureDetector(
                      onTap: () {
                        _updateCategory(index);
                      },
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                          padding: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                          alignment: Alignment.center,
                          //width: 70,
                          height: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: driverRating.value[index].isSelected ==
                                          true
                                      ? AppColor.red
                                      : AppColor.darkGrey),
                              borderRadius: BorderRadius.circular(20)),
                          child: appText(
                              driverRating.value[index].data.toString(),
                              style:
                                  driverRating.value[index].isSelected == true
                                      ? AppTextStyle.subTitle2.copyWith(
                                          fontWeight: FontWeight.w800,
                                        )
                                      : AppTextStyle.greySubTitle
                                          .copyWith(fontSize: Sizes.s14.sp))),
                    ),
                  ]);
                },
              );
            },
          ),
        ),
        Row(
          children: [
            ...List.generate(
                5,
                (index) => IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.star,
                      size: Sizes.s40.h,
                      color: AppColor.red,
                    )))
          ],
        ),
        SizedBoxH14(),
        PrimaryButton(lable: "Done", onPressed: () {})
      ],
    );
  }

  Widget chatBox() {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: Sizes.s10.w, vertical: Sizes.s10.h),
      padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
      height: ScreenUtil().screenWidth / 1.5,
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(2, 4),
              blurRadius: 7,
              spreadRadius: 2,
              color: Theme.of(context).shadowColor)
        ],
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBoxH10(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: Sizes.s22.r,
                  backgroundImage: AssetImage(AppAsset.driverPhoto),
                ),
                SizedBoxW8(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText("Deni Olgano",
                        style: AppTextStyle.blackSubTitle.copyWith(
                            color: Theme.of(context).brightness ==
                                    ThemeUtils.darkTheme.brightness
                                ? AppColor.darkTextColor
                                : AppColor.black,
                            fontWeight: FontWeight.w700)),
                    appText("7 Dec 2021",
                        style: AppTextStyle.subTitle2.copyWith(
                            color: AppColor.driverProfileSubtitleColor))
                  ],
                ),
                const Expanded(child: SizedBox()),
                ratingButton(color: AppColor.lightGreenColor)
              ],
            ),
          ),
          Container(
            constraints:
                BoxConstraints(minHeight: ScreenUtil().screenWidth / 3),
            padding: EdgeInsets.symmetric(
                horizontal: Sizes.s10.w, vertical: Sizes.s10.w),
            margin: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
            // height: ScreenUtil().screenWidth / 2.5,
            decoration: BoxDecoration(
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                borderRadius: BorderRadius.circular(5)),
            child: appText("chatBox",
                softWrap: true, style: AppTextStyle.blackSubTitle),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(right: Sizes.s8.w),
                    child: SvgPicture.asset(
                      AppAsset.downArrow,
                      height: Sizes.s10.h,
                      width: Sizes.s10.w,
                      color: Theme.of(context).brightness ==
                              ThemeUtils.darkTheme.brightness
                          ? AppColor.darkTextColor
                          : AppColor.black,
                    )),
                RichText(
                  text: TextSpan(
                      text: "ThankYou ".tr(),
                      style: AppTextStyle.headline2.copyWith(
                          color: Theme.of(context).brightness ==
                                  ThemeUtils.darkTheme.brightness
                              ? AppColor.lightGreenColor
                              : AppColor.black),
                      children: const [
                        TextSpan(
                            text: "@ Deni Olgano",
                            style: AppTextStyle.greySubTitle)
                      ]),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget commonCard(
      {String? title,
      String? subTitle,
      String? image,
      bool isImage = false,
      bool isDownload = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.s10.h),
      child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes.s16.w, vertical: Sizes.s10.h),
          width: ScreenUtil().screenWidth,
          height: Sizes.s80.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor),
          child: isImage == true
              ? Center(
                  child: Image.asset(
                    image ?? "",
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText(
                            title ?? "",
                            style: AppTextStyle.headline2,
                          ),
                          SizedBoxW8(),
                          appText(subTitle ?? "",
                              style: AppTextStyle.subTitle.copyWith(
                                  color: Theme.of(context).brightness ==
                                          ThemeUtils.darkTheme.brightness
                                      ? AppColor.darkThemeSubTitle
                                      : AppColor.driverProfileSubtitleColor))
                        ],
                      ),
                      isDownload == true
                          ? downloadButton()
                          : const SizedBox.shrink()
                    ])),
    );
  }

  Widget downloadButton() {
    return Container(
      alignment: Alignment.center,
      height: Sizes.s80.h,
      width: Sizes.s80.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.darkThemeScaffoldBackground
              : AppColor.white),
      child: Image.asset(
        AppAsset.downloadIcon,
        height: Sizes.s30.h,
        width: Sizes.s30.w,
      ),
    );
  }

  Widget ratingButton(
      {VoidCallback? onPressed, Color? color, bool isLikeButton = false}) {
    return Row(children: [
      InkWell(
        onTap: onPressed,
        child: Container(
          width: Sizes.s80.w,
          //  height: Sizes.s50.h,
          decoration: ShapeDecoration(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : color ?? AppColor.white,
              shape: const StadiumBorder()),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appText('4.5',
                    style: AppTextStyle.headingTextTile.copyWith(
                        color: Theme.of(context).brightness ==
                                ThemeUtils.darkTheme.brightness
                            ? AppColor.darkTextColor
                            : AppColor.black)),
                Icon(
                  Icons.star,
                  color: Theme.of(context).brightness ==
                          ThemeUtils.darkTheme.brightness
                      ? AppColor.darkTextColor
                      : AppColor.black,
                )
              ],
            ),
          ),
        ),
      ),
      SizedBoxW8(),
      isLikeButton == true ? likeButton() : const SizedBox.shrink()
    ]);
  }

  void _updateCategory(int index) {
    driverRating.value[index].isSelected =
        !driverRating.value[index].isSelected;
    driverRating.notifyListeners();
  }

  Widget likeButton() {
    return CircleAvatar(
      backgroundColor: AppColor.white,
      radius: Sizes.s24.r,
      child: const Icon(
        Icons.favorite_outline_rounded,
        //size: Sizes.s30.h,
      ),
    );
  }

  // Positioned(
  // child: Align(
  // alignment: Alignment.topCenter,
  // child: TabBar(
  // controller: tabController,
  // tabs: const [
  // Tab(
  // text: "hello",
  // ),
  // Tab(
  // text: "hello",
  // )
  // ],
  // ),
  // ))

}

class DriverRatingList {
  String? data;
  bool isSelected;

  DriverRatingList({this.data, required this.isSelected});
}

ValueNotifier<List<DriverRatingList>> _driverRating = ValueNotifier([
  DriverRatingList(data: "Over all Experience", isSelected: false),
  DriverRatingList(data: "Driver Attitude", isSelected: false),
  DriverRatingList(data: "Driver Behaviour", isSelected: false),
]);

ValueNotifier<List<DriverRatingList>> get driverRating => _driverRating;
