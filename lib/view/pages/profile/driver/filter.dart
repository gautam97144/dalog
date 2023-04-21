import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterBy extends StatefulWidget {
  const FilterBy({Key? key}) : super(key: key);

  @override
  State<FilterBy> createState() => _FilterByState();
}

class _FilterByState extends State<FilterBy> {
  static const min = 0.0;
  static const max = 10.0;
  ValueNotifier<List<double>> range = ValueNotifier([0.0, 10.0]);
  ValueNotifier<int> intialIndex = ValueNotifier(0);
  // double low = range.value[0];
  // double high = max;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Filter by",
      ),
      body: CustomScroll(
        children: [
          CustomSizedBox(),
          Row(children: [
            appText("No. of Deliveries", style: AppTextStyle.headingTextTile),
            SizedBoxW8(),
            rangeBox()
          ]),
          ValueListenableBuilder(
            valueListenable: range,
            builder: (BuildContext context, List<double> value, Widget? child) {
              return RangeSlider(
                  activeColor: AppColor.primaryColor,
                  inactiveColor: AppColor.lightGrey,
                  min: double.parse(range.value[0].toString()),
                  max: double.parse(range.value[1].toString()),
                  divisions: 10,
                  values: RangeValues(range.value[0], range.value[1]),
                  onChanged: (data) {
                    data.runtimeType;
                    range.value[0] = data.start;
                    range.value[1] = data.end;
                    range.notifyListeners();
                    // setState(() {
                    //   low = value.start;
                    //   high = value.end;
                    // });
                  });
            },
            //  child:
          ),
          appText("Ratings", style: AppTextStyle.headingTextTile),
          ValueListenableBuilder(
            valueListenable: intialIndex,
            builder: (BuildContext context, int value, Widget? child) {
              return rating();
            },
          ),
          SizedBoxH28(),
          appText("Sort by", style: AppTextStyle.headingTextTile),
          SizedBoxH10(),
          ValueListenableBuilder(
            valueListenable: filter,
            builder: (BuildContext context, List<Filter> value, Widget? child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: filter.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      filter.value[index].isSelected =
                          !filter.value[index].isSelected;
                      filter.notifyListeners();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Sizes.s10.h),
                      child: Row(
                        children: [
                          SmallRedCircularIcon(
                            color: filter.value[index].isSelected == true
                                ? AppColor.red
                                : Theme.of(context).cardColor,
                            isChecked: filter.value[index].isSelected == true
                                ? false
                                : true,
                            //AppColor.lightGrey,
                          ),
                          SizedBoxW8(),
                          appText(filter.value[index].data.toString(),
                              style: AppTextStyle.blackSubTitle)
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget rating() {
    return Row(
      children: [
        ...List.generate(
            5,
            (index) => IconButton(
                  icon: Icon(Icons.star,
                      size: Sizes.s50.h,
                      color: intialIndex.value > index
                          ? AppColor.red
                          : Theme.of(context).cardColor),
                  onPressed: () {
                    intialIndex.value = index + 1;
                  },
                ))
      ],
    );
  }

  Widget rangeBox() {
    return GestureDetector(
      onTap: () => CustomBottomSheet.showBottomSheet(
          color: Theme.of(context).cardColor,
          height: ScreenUtil().screenWidth / 2,
          context,
          [_bottomSheetContent()]),
      child: Container(
        //width: Sizes.s50.w,
        padding: EdgeInsets.fromLTRB(
            Sizes.s10.w, Sizes.s5.h, Sizes.s10.w, Sizes.s5.h),
        decoration: ShapeDecoration(
            shape: const StadiumBorder(),
            color:
                Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                    ? AppColor.darkLightRed
                    : AppColor.lightRed),
        child: appText("10-100",
            style: AppTextStyle.redTextStyle
                .copyWith(fontWeight: FontWeight.w400)),
      ),
    );
  }

  Widget _bottomSheetContent() {
    return Column(
      children: [
        SizedBoxH28(),
        ValueListenableBuilder(
          valueListenable: verifyDriver,
          builder: (BuildContext context, value, Widget? child) {
            final value = verifyDriver.value;
            return ListView.builder(
                itemCount: value.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _upDate(index);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(bottom: Sizes.s10.h),
                      child: Row(
                        children: [
                          SmallRedCircularIcon(
                            color: value[index].isSelected == true
                                ? AppColor.red
                                : Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.darkThemeScaffoldBackground
                                    : AppColor.darkGrey,
                            isChecked:
                                value[index].isSelected == true ? false : true,
                          ),
                          SizedBoxW8(),
                          appText(verifyDriver.value[index].data.toString(),
                              style: AppTextStyle.blackSubTitle)
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
        SizedBoxH28(),
        PrimaryButton(lable: "Done", onPressed: () {})
      ],
    );
  }
}

void _upDate(int index) {
  for (var element in verifyDriver.value) {
    element.isSelected = false;
  }
  verifyDriver.value[index].isSelected = true;
  verifyDriver.notifyListeners();
}

class Filter {
  String? data;
  bool isSelected;

  Filter({this.data, required this.isSelected});
}

ValueNotifier<List<Filter>> filter = ValueNotifier([
  Filter(data: "Top rated drivers", isSelected: false),
  Filter(data: "Most popular", isSelected: false)
]);

class VerifyDriver {
  String? data;
  bool? isSelected;

  VerifyDriver({this.isSelected, this.data});
}

ValueNotifier<List<VerifyDriver>> verifyDriver = ValueNotifier([
  VerifyDriver(data: "Only show Verified Drivers", isSelected: false),
  VerifyDriver(data: "Only show Favorite Drivers", isSelected: false)
]);
