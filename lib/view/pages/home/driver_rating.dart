import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:flutter/material.dart';

import '../../../models/rating.dart';
import '../../../models/tip_model.dart';
import '../../../routs/app_routs.dart';
import '../../widgets/widget.dart';

class DriverRating extends StatelessWidget {
  DriverRating({Key? key}) : super(key: key);

  ValueNotifier<int> initialIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: SecondaryAppBar(),
      body: CustomScroll(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: rating.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    appText(rating[index].title.toString(),
                        style: AppTextStyle.blackSubTitle),
                    SizedBoxH10(),
                    _ratingBar(),
                    SizedBoxH28(),
                  ],
                );
              }),
          appText("Share your experience (Review)",
              style: AppTextStyle.headingTextTile),
          SizedBoxH14(),
          const SecondaryTextField(
            hintText: "Type here...",
          ),
          SizedBoxH28(),
          appText(
            "Add a tip for Feni",
            style: AppTextStyle.headingTextTile,
          ),
          SizedBoxH14(),
          _tipList(),
          SizedBoxH28(),
          const PrimaryTextField(
            hintText: "Type custom tip amount..",
          ),
          SizedBoxH28(),
          PrimaryButton(
              lable: "Done",
              onPressed: () {
                Navigator.pushNamed(context, Routs.payTip);
              }),
          SizedBoxH10(),
        ],
      ),
    );
  }

  Widget _tipList() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tip.value.length,
        itemBuilder: (BuildContext context, int index) {
          return ValueListenableBuilder(
            valueListenable: tip,
            builder: (BuildContext context, List<Tip> value, Widget? child) {
              return GestureDetector(
                onTap: () {
                  _updateDiamension(index);
                },
                child: Container(
                    constraints: BoxConstraints(minWidth: Sizes.s50.w),
                    margin: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                    padding: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                    alignment: Alignment.center,
                    //width: Sizes.s20.w,
                    //constraints: BoxConstraints(minWidth: 50),
                    //height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: tip.value[index].isSelected == true
                                ? AppColor.red
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                    child: appText(tip.value[index].name.toString(),
                        style: tip.value[index].isSelected == true
                            ? AppTextStyle.subTitle2.copyWith(
                                fontWeight: FontWeight.w800,
                              )
                            : AppTextStyle.greySubTitle
                                .copyWith(fontSize: Sizes.s14.sp))),
              );
            },
          );
        },
      ),
    );
  }

  Widget _ratingBar() {
    return Row(
      children: [
        ...List.generate(
            5,
            (index) => ValueListenableBuilder(
                  valueListenable: initialIndex,
                  builder: (BuildContext context, int value, Widget? child) {
                    return IconButton(
                      onPressed: () {
                        initialIndex.value = index + 1;
                      },
                      icon: Icon(
                        Icons.star,
                        size: Sizes.s36.h,
                      ),
                      color: index < initialIndex.value
                          ? AppColor.red
                          : Theme.of(context).cardColor,
                    );
                  },
                ))
      ],
    );
  }

  void _updateDiamension(int index) {
    for (var element in tip.value) {
      element.isSelected = false;
    }
    tip.value[index].isSelected = true;

    //tip.value[index].isSelected = !tip.value[index].isSelected;
    tip.notifyListeners();
  }
}
