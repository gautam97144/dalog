import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/models/filter_popup_model.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/job_list_model.dart';
import '../../../models/my_job_model.dart';
import '../../../routs/app_routs.dart';
import '../../../services/auth_service.dart';

class MyListing extends StatefulWidget {
  MyListing({Key? key}) : super(key: key);

  @override
  State<MyListing> createState() => _MyListingState();
}

class _MyListingState extends State<MyListing>
    with SingleTickerProviderStateMixin {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  CustomPopupMenuController _controller = CustomPopupMenuController();

  TabController? tabController;
  int? index;
  List<GetJobListDataModel>? openJobList = [];
  List<GetJobListDataModel>? getDraftJobList = [];
  List<GetJobListDataModel>? getMyCompletedJobList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    tabController =
        TabController(length: 3, vsync: this, animationDuration: Duration.zero);
  }

  getData() {
    ApiService().getOpenJobList().then((value) {
      if (value!.sucecess = true) {
        setState(() {
          openJobList = value.data!;
        });
      }
    });
    ApiService().getDraftJobList().then((value) {
      if (value!.sucecess = true) {
        setState(() {
          getDraftJobList = value.data!;
        });
      }
    });
    ApiService().getMyCompletedJobList().then((value) {
      if (value!.sucecess = true) {
        setState(() {
          getMyCompletedJobList = value.data!;
        });
      }
    });
  }

  List<ItemModel> menuItem = [
    ItemModel(name: "Edit"),
    ItemModel(name: "Remove")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.darkThemeScaffoldBackground
              : AppColor.lightGrey,
      appBar: TabAppBar(
        onTap: () => Navigator.pushNamed(context, Routs.profile),
        onPressed: () {
          CustomDialog.dialogShow(context, children: [filterPopUp()]);
        },
        title: "My Jobs",
        action: Image.asset(
          AppAsset.filter,
          color: Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
              ? AppColor.white
              : AppColor.black,
          height: 30,
          width: 30,
        ),
        leading: Image.asset(
          AppAsset.drawer,
          height: 30,
          width: 30,
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
                    setState(() {
                      selectedIndex.value = index;
                      print('selectedIndex --> ${index}');
                    });
if(index ==0){
  ApiService().getOpenJobList().then((value) {
    if (value!.sucecess = true) {
      setState(() {
        openJobList = value.data!;
      });
    }
  });
}
                   // getData();
                  },
                  indicatorPadding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  tabs: const [
                    Tab(
                      text: "Open",
                    ),
                    Tab(
                      text: "Draft",
                    ),
                    Tab(
                      text: "Completed",
                    ),
                  ],
                ),
              ),
            )),
      ),
      //backgroundColor: AppColor.homeScreenBackground,
      body: TabBarView(
          controller: tabController,
          children: [openList(context), draftList(), completedList()]),
    );
  }

  Widget openList(BuildContext context) {
    return openJobList.toString() == '[]'
        ? Center(
            child: Container(
              child: appText('Data Not Found', color: AppColor.grey),
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: openJobList!.length,
            itemBuilder: (context, inx) {
              ///index = inx;
              return JobListBox(
                onPressed: () {
                  Navigator.pushNamed(context, Routs.openJob);
                },
                popupMenuButton:  Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: PopupMenuButton(
                      color: const Color(0xFF4C4C4C),
                      key: openJobList![inx].menuKey,
                      itemBuilder: (_) => <PopupMenuItem<String>>[
                        PopupMenuItem<String>(
                            value: 'Edit',
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                        PopupMenuItem<String>(
                            value: 'Remove',
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add,
                                  size: 15,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Remove',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )),
                      ],
                      onSelected: (val) {
                        print(val);
                        if (val == 'Remove') {
                          ApiService()
                              .deleteJobApi(
                              openJobList![inx].id.toString())
                              .then((value) {
                            getData();
                          });
                        } else {}
                      }),
                ),
                // CustomPopupMenu(
                //   menuBuilder: () => openJobList![inx].isSelected == true
                //       ? ClipRRect(
                //           borderRadius: BorderRadius.circular(5),
                //           child: Container(
                //             color: const Color(0xFF4C4C4C),
                //             child: IntrinsicWidth(
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.stretch,
                //                 children: menuItem
                //                     .map(
                //                       (item) => GestureDetector(
                //                         behavior: HitTestBehavior.translucent,
                //                         onTap: () {
                //                           if (item.name == 'Remove') {
                //                             ApiService()
                //                                 .deleteJobApi(openJobList![inx]
                //                                     .id
                //                                     .toString())
                //                                 .then((value) {
                //                               getData();
                //                             });
                //                           } else {}
                //                           print("onTap--> ${item.name}");
                //                           // _controller.hideMenu();
                //                         },
                //                         child: Container(
                //                           height: 40,
                //                           padding: const EdgeInsets.symmetric(
                //                               horizontal: 20),
                //                           child: Row(
                //                             children: <Widget>[
                //                               const Icon(
                //                                 Icons.add,
                //                                 size: 15,
                //                                 color: Colors.white,
                //                               ),
                //                               Expanded(
                //                                 child: Container(
                //                                   margin: const EdgeInsets.only(
                //                                       left: 10),
                //                                   padding: const EdgeInsets
                //                                       .symmetric(vertical: 10),
                //                                   child: Text(
                //                                     item.name.toString(),
                //                                     style: const TextStyle(
                //                                       color: Colors.white,
                //                                       fontSize: 12,
                //                                     ),
                //                                   ),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       ),
                //                     )
                //                     .toList(),
                //               ),
                //             ),
                //           ),
                //         )
                //       : const SizedBox(),
                //   pressType: PressType.singleClick,
                //   verticalMargin: -10,
                //   controller: _controller,
                //   child: const Icon(Icons.more_vert_rounded),
                // ),
                status: "Assigned to",
                name: "Dani cobada",
                detail: "Track Now",
                image: CircleAvatar(
                    radius: Sizes.s14.r,
                    child: Image.asset(AppAsset.driverProfile)),
                style: AppTextStyle.buttonTextStyle,
                color: AppColor.primaryColor,
                title: openJobList![inx].jobTittle.toString(),
                amount: openJobList![inx].cost.toString(),
              );
            });
  }

  Widget draftList() {
    return getDraftJobList.toString() == '[]'
        ? Center(
            child: Container(
              child: appText('Data Not Found', color: AppColor.grey),
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: getDraftJobList!.length,
            itemBuilder: (context, index) {
              return JobListBox(
                  popupMenuButton: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: PopupMenuButton(
                        color: const Color(0xFF4C4C4C),
                        key: getDraftJobList![index].menuKey,
                        itemBuilder: (_) => <PopupMenuItem<String>>[
                              PopupMenuItem<String>(
                                  value: 'Edit',
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )),
                              PopupMenuItem<String>(
                                  value: 'Remove',
                                  child: Row(
                                    children: const [
                                      Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        'Remove',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                        onSelected: (val) {
                          print(val);
                          if (val == 'Remove') {
                            ApiService()
                                .deleteJobApi(
                                    getDraftJobList![index].id.toString())
                                .then((value) {
                              getData();
                            });
                          } else {}
                        }),
                  ),
                  // popupMenuButton: CustomPopupMenu(
                  //   menuBuilder: () => getDraftJobList![index].isSelected == true
                  //       ? ClipRRect(
                  //     borderRadius: BorderRadius.circular(5),
                  //     child: Container(
                  //       color: const Color(0xFF4C4C4C),
                  //       child: IntrinsicWidth(
                  //         child: Column(
                  //           crossAxisAlignment: CrossAxisAlignment.stretch,
                  //           children: menuItem
                  //               .map(
                  //                 (item) => GestureDetector(
                  //               behavior: HitTestBehavior.translucent,
                  //               onTap: () {
                  //                 if(item.name =='Remove'){
                  //                   ApiService().deleteJobApi(getDraftJobList![index].id.toString()).then((value) {
                  //                     getData();
                  //                   });
                  //                 }else{
                  //                 }
                  //                 print("onTap--> ${item.name}");
                  //                 // _controller.hideMenu();
                  //               },
                  //               child: Container(
                  //                 height: 40,
                  //                 padding:
                  //                 const EdgeInsets.symmetric(horizontal: 20),
                  //                 child: Row(
                  //                   children: <Widget>[
                  //                     const Icon(
                  //                       Icons.add,
                  //                       size: 15,
                  //                       color: Colors.white,
                  //                     ),
                  //                     Expanded(
                  //                       child: Container(
                  //                         margin: const EdgeInsets.only(
                  //                             left: 10),
                  //                         padding:
                  //                         const EdgeInsets.symmetric(
                  //                             vertical: 10),
                  //                         child: Text(
                  //                           item.name.toString(),
                  //                           style: const TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 12,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ),
                  //             ),
                  //           )
                  //               .toList(),
                  //         ),
                  //       ),
                  //     ),
                  //   )
                  //       : const SizedBox(),
                  //   pressType: PressType.singleClick,
                  //   verticalMargin: -10,
                  //   controller: _controller,
                  //   child: const Icon(Icons.more_vert_rounded),
                  // ),
                  status:
                      "Drafted on ${DateFormat('MMM dd,').format(DateTime.parse(getDraftJobList![index].createdAt.toString()))} ${DateFormat('hh:kk a').format(DateTime.parse(getDraftJobList![index].createdAt.toString()))}",
                  color: Theme.of(context).brightness ==
                          ThemeUtils.darkTheme.brightness
                      ? AppColor.darkThemeScaffoldBackground
                      : AppColor.lightPrimaryColor,
                  detail: "Complete Details & Post",
                  isBorder: true,
                  title: getDraftJobList![index].jobTittle!.isEmpty
                      ? ''
                      : getDraftJobList![index].jobTittle.toString());
            });
  }

  Widget completedList() {
    return getMyCompletedJobList.toString() == '[]'
        ? Center(
            child: Container(
              child: appText('Data Not Found', color: AppColor.grey),
            ),
          )
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: getMyCompletedJobList!.length,
            itemBuilder: (context, index) {
              return JobListBox(
                onPressed: () =>
                    Navigator.pushNamed(context, Routs.completedJob),
                status: "Drafted on",
                title: getMyCompletedJobList![index].jobTittle.toString(),
                amount: getMyCompletedJobList![index].cost.toString(),
                detail: "Get Details",
                style: AppTextStyle.buttonTextStyle,
                color: AppColor.primaryColor,
              );
            });
  }

  Widget filterPopUp() {
    return SizedBox(
      height: ScreenUtil().screenWidth / 1.2,
      width: ScreenUtil().screenWidth / 1.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText("Sort by date",
                  style: AppTextStyle.headingTextTile2
                      .copyWith(fontWeight: FontWeight.w900)),
              appText("Custom Range",
                  style: AppTextStyle.redTextStyle
                      .copyWith(fontWeight: FontWeight.w900))
            ],
          ),
          SizedBox(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: Filter.getFilter.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          Filter.getFilter[index].image.toString(),
                          height: Sizes.s40.h,
                          width: Sizes.s40.w,
                        ),
                        SizedBoxW10(),
                        appText(Filter.getFilter[index].day.toString(),
                            style: AppTextStyle.blackSubTitle
                                .copyWith(fontWeight: FontWeight.w700)),
                        Expanded(child: SizedBoxW10()),
                        appText(Filter.getFilter[index].date.toString(),
                            style: AppTextStyle.blackSubTitle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.filterPopUpTextColor
                                    : AppColor.filterPopUpTextColorLight))
                      ],
                    ),
                    SizedBoxH10()
                  ]);
                }),
          )
        ],
      ),
    );
  }
}

class ItemModel {
  String? name;

  ItemModel({this.name});
}
