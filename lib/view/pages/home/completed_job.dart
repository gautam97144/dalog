import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constant/app_text_style.dart';
import '../../../constant/constant.dart';
import '../../../routs/app_routs.dart';
import '../../../utils/utils.dart';
import '../../widgets/widget.dart';
import 'create_job/create_job_second/create_job_second.dart';
import 'open_job/dialog.dart';

class CompletedJob extends StatelessWidget {
  CompletedJob({Key? key}) : super(key: key);

  final ValueNotifier<List<CategoryName>> _categoryName = ValueNotifier([
    CategoryName(name: "Furniture", isSelected: false),
    CategoryName(name: "Clothing", isSelected: false),
    CategoryName(name: "Grocery", isSelected: false),
    CategoryName(name: "Luggage", isSelected: false),
    CategoryName(name: "Medical Equipment", isSelected: false)
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(ScreenUtil().screenWidth / 2),
        child: AppBar(
            title: appText("Posted on Jan 23, 11:10pm",
                style: AppTextStyle.greySubTitle),
            actions: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: appText("completed",
                        style: AppTextStyle.greySubTitle.copyWith(
                            color: AppColor.orange,
                            fontWeight: FontWeight.w900)),
                  ))
            ],
            // flexibleSpace: appText("Posted on Jan 23, 11:10pm",
            //     style: AppTextStyle.greySubTitle),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_outlined),
                color: AppColor.red,
                onPressed: () => Navigator.pop),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(ScreenUtil().screenWidth / 2),
              child: PrimaryPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    appText("\$225",
                        style: AppTextStyle.headingTextTile2
                            .copyWith(color: AppColor.primaryColor)),
                    appText("Pickup a Car & bike from Fillmore",
                        style: AppTextStyle.headingTextTile2),
                    SizedBoxH10(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: "Customer".tr(),
                                style: AppTextStyle.greySubTitle,
                                children: [
                              WidgetSpan(
                                  child: Image.asset(
                                AppAsset.driverProfile,
                                height: Sizes.s30.h,
                                width: Sizes.s30.w,
                              )),
                              const TextSpan(
                                text: "Omigo Tialado",
                                style: AppTextStyle.blackSubTitle,
                              ),
                              WidgetSpan(
                                  child: Image.asset(
                                AppAsset.editIcon,
                                height: Sizes.s20.h,
                                width: Sizes.s20.w,
                              ))
                            ])),
                        SvgPicture.asset(
                          AppAsset.call,
                          height: Sizes.s40.h,
                          width: Sizes.s40.w,
                        )
                      ],
                    ),
                    SizedBoxH10()
                  ],
                ),
              ),
            )),
      ),
      body: CustomScroll(
        children: [
          SizedBoxH14(),
          // Row(
          //   //crossAxisAlignment: CrossAxisAlignment.start,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     InkWell(
          //       onTap: () {
          //         Navigator.pop(context);
          //       },
          //       child: const Icon(
          //         Icons.arrow_back_ios_outlined,
          //         color: AppColor.red,
          //       ),
          //     ),
          //     appText("Posted on Jan 23, 11:10pm",
          //         style: AppTextStyle.greySubTitle),
          //     appText("open",
          //         style: AppTextStyle.greySubTitle.copyWith(
          //             color: AppColor.orange, fontWeight: FontWeight.w900))
          //   ],
          // ),
          // SizedBoxH14(),
          // appText("\$225",
          //     style: AppTextStyle.headingTextTile2
          //         .copyWith(color: AppColor.primaryColor)),
          // appText("Pickup a Car & bike from Fillmore",
          //     style: AppTextStyle.headingTextTile2),
          //SizedBoxH28(),
          _horizontalCategoryList(),
          SizedBoxH14(),
          _luggageImage(context),
          SizedBoxH28(),
          _stepper(),
          SizedBoxH14(),
          Container(
            height: ScreenUtil().screenWidth / 1.5,
            width: ScreenUtil().screenWidth,
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 3)
            ], color: AppColor.white),
          )
        ],
      ),
    );
  }

  Widget _pickUpLocationAndDropOfLocation(
      {required String title,
      required String address,
      required String locationTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        appText(title,
            style:
                AppTextStyle.subTitle.copyWith(color: AppColor.primaryColor)),
        SizedBoxH10(),
        appText(address, style: AppTextStyle.headingTextTile, softWrap: true),
        SizedBoxH10(),
        appText(locationTitle, style: AppTextStyle.greySubTitle),
        SizedBoxH10()
      ],
    );
  }

  Widget _specialInstructionBox(
      {Color? color, TextStyle? style, String? data, String? instruction}) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: Sizes.s14.w, vertical: Sizes.s10.h),
      width: ScreenUtil().screenWidth,
      height: ScreenUtil().screenWidth / 3,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius), color: color),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          appText(instruction!, style: AppTextStyle.greySubTitle),
          SizedBoxH10(),
          appText(data!, style: style, softWrap: true)
        ],
      ),
    );
  }

  Widget _stepper() {
    return Stepper(
        controlsBuilder: (context, ControlsDetails) {
          return const SizedBox();
        },
        physics: const NeverScrollableScrollPhysics(),
        steps: [
          Step(
              title: const Text(""),
              content: Column(
                children: [
                  _pickUpLocationAndDropOfLocation(
                      locationTitle: 'Pickup Location',
                      title: 'As soon as possible',
                      address:
                          '1529 Fillmore St, San Francisco,CA 94115, United States'),
                  _specialInstructionBox(
                      instruction: "Special Instructions",
                      color: AppColor.lightRed,
                      data:
                          "It is a long established fact that a reader will be distracted by the.",
                      style: AppTextStyle.headingTextTile),
                  SizedBoxH10(),
                  _specialInstructionBox(
                      instruction: "Contact",
                      data: "Deni Codider \n +1 123456789",
                      style: AppTextStyle.headingTextTile,
                      color: AppColor.lightGrey),
                  SizedBoxH10(),
                  _pickUpLocationAndDropOfLocation(
                      locationTitle: 'Drop-off Location',
                      title: 'Apr 26, 2022, 06:30pm',
                      address:
                          '600 The Embarcadero,San Francisco, CA 94107,United States'),
                ],
              )),
          Step(content: Text(""), title: Text(""))
        ]);
  }

  Widget _horizontalCategoryList() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
          //controller: controller,
          scrollDirection: Axis.horizontal,
          itemCount: _categoryName.value.length,
          itemBuilder: (context, index) {
            return Row(children: [
              ValueListenableBuilder(
                valueListenable: _categoryName,
                builder: (BuildContext context, value, Widget? child) {
                  return GestureDetector(
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
                                color: _categoryName.value[index].isSelected ==
                                        true
                                    ? AppColor.red
                                    : AppColor.darkGrey),
                            borderRadius: BorderRadius.circular(20)),
                        child: appText(
                            _categoryName.value[index].name.toString(),
                            style: _categoryName.value[index].isSelected == true
                                ? AppTextStyle.subTitle2.copyWith(
                                    fontWeight: FontWeight.w800,
                                  )
                                : AppTextStyle.greySubTitle
                                    .copyWith(fontSize: Sizes.s14.sp))),
                  );
                },
              ),
            ]);
          }),
    );
  }

  Widget _luggageImage(BuildContext context) {
    return Stack(children: [
      Container(
        padding: EdgeInsets.symmetric(vertical: Sizes.s12.h),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius)),
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenWidth / 1.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            appText("3 Seat Sofa", style: AppTextStyle.headingTextTile),
            Image.asset(AppAsset.sofa),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(
                  //   height: Sizes.s80.h,
                  //   child: ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: imageDetail?.imageDetailList.length,
                  //     scrollDirection: Axis.horizontal,
                  //     itemBuilder: (_, index) {
                  //       return Column(
                  //         children: [
                  //           appText(
                  //               imageDetail!.imageDetailList[index].title
                  //                   .toString(),
                  //               style: AppTextStyle.greySubTitle),
                  //           appText(
                  //               imageDetail!.imageDetailList[index].dimension
                  //                   .toString(),
                  //               style: AppTextStyle.blackSubTitle)
                  //         ],
                  //       );
                  //     },
                  //   ),
                  // )

                  Column(
                    children: [
                      appText("Length", style: AppTextStyle.greySubTitle),
                      appText("48”")
                    ],
                  ),
                  Column(
                    children: [
                      appText("Width", style: AppTextStyle.greySubTitle),
                      appText("12”")
                    ],
                  ),
                  Column(
                    children: [
                      appText("Height", style: AppTextStyle.greySubTitle),
                      appText("36”")
                    ],
                  ),
                  Column(
                    children: [
                      appText("Weight", style: AppTextStyle.greySubTitle),
                      appText("20LBS")
                    ],
                  ),
                  Column(
                    children: [
                      appText("Quantity", style: AppTextStyle.greySubTitle),
                      appText("1")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
      Positioned.fill(
          child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    forwardAndBackWardButton(Icons.arrow_back_ios_outlined),
                    forwardAndBackWardButton(Icons.arrow_forward_ios_outlined)
                  ],
                ),
              )))
    ]);
  }

  Widget forwardAndBackWardButton(IconData icon) {
    return CircleAvatar(
      radius: Sizes.s16.r,
      backgroundColor: AppColor.white,
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }

  Widget cancelDialog(BuildContext context) {
    return SizedBox(
      width: ScreenUtil().screenWidth / 1.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appText("What is wrong?", style: AppTextStyle.headline2),
            ],
          ),
          SizedBoxH14(),
          missingSelectionWidget(title: "Missing items"),
          missingSelectionWidget(title: "Damaged items"),
          appText("Describe other issue", style: AppTextStyle.headline2),
          SizedBoxH10(),
          SecondaryTextField(
            hintText: "Describe here...",
          ),
          SizedBoxH14(),
          PrimaryButton(
              lable: "Submit",
              onPressed: () {
                CustomDialog.dialogShow(context, children: [
                  AllDialogWidget.deleteListing(
                      title: SvgPicture.asset(
                        AppAsset.truck,
                        height: Sizes.s50.h,
                        width: Sizes.s50.w,
                      ),
                      heading: "Successfully Delivered",
                      endTitle: "Back to My Listing",
                      data:
                          "Your delivery has arrived to your target destination!",
                      button: PrimaryButton(
                          lable: "Rate your Driver",
                          onPressed: () {
                            Navigator.pushNamed(context, Routs.driverRating);
                          }))
                ]);
              }),
          SizedBoxH10(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: appText("Go Back", style: AppTextStyle.redTextStyle))
          ])
        ],
      ),
    );
  }

  Widget missingSelectionWidget({String? title}) {
    return Padding(
      padding: EdgeInsets.only(bottom: Sizes.s10.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
        height: Sizes.s50.h,
        decoration: const ShapeDecoration(
          shape: StadiumBorder(side: BorderSide(width: 1, color: AppColor.red)),
        ),
        child: Row(
          children: [
            SmallRedCircularIcon(
              raduis: Sizes.s14.r,
            ),
            SizedBoxW10(),
            appText(title!, style: AppTextStyle.subTitle)
          ],
        ),
      ),
    );
  }

  Widget confirmDelivery(
      {String? heading,
      String? data,
      Widget? confirmMethodOne,
      Widget? confirmMethodTwo}) {
    return SizedBox(
      width: ScreenUtil().screenWidth / 1.4,
      child: Column(
        children: [
          SizedBoxH14(),
          appText(heading!, style: AppTextStyle.headline2),
          SizedBoxH14(),
          appText(data!,
              softWrap: true,
              textAlign: TextAlign.center,
              style: AppTextStyle.blackSubTitle),
          SizedBoxH14(),
          confirmMethodOne!,
          confirmMethodTwo!,
          SizedBoxH14(),
          appText("If something wrong?", style: AppTextStyle.redTextStyle),
          SizedBoxH14()
        ],
      ),
    );
  }

  Widget confirmDeliveryMethodBox({String? data, VoidCallback? onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.only(bottom: Sizes.s10.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
          width: ScreenUtil().screenWidth / 1,
          height: Sizes.s70.h,
          decoration: BoxDecoration(
              color: AppColor.lightGrey,
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText(data!, style: AppTextStyle.headline2),
                circularForwardButton()
              ]),
        ),
      ),
    );
  }

  // Widget verifyByImage() {
  //   return Column(
  //     children: [
  //       appText("Confirm by Images", style: AppTextStyle.headline2),
  //       appText("Let’s verifiy Compare image with actual delivered items",style: )
  //     ],
  //   );
  // }

  Widget circularForwardButton() {
    return CircleAvatar(
        backgroundColor: AppColor.primaryColor,
        radius: Sizes.s14.r,
        child: const Center(
          child: Icon(
            Icons.keyboard_arrow_right_outlined,
            color: AppColor.white,
          ),
        ));
  }

  void _updateCategory(int index) {
    _categoryName.value[index].isSelected =
        !_categoryName.value[index].isSelected;
    _categoryName.notifyListeners();
  }
}

class ImageDetail {
  String? title;
  String? dimension;

  ImageDetail({this.title, this.dimension});

  List<ImageDetail> imageDetailList = [
    ImageDetail(title: "Length", dimension: "48”"),
    ImageDetail(title: "Width", dimension: "12”"),
    ImageDetail(title: "Height", dimension: "36”"),
    ImageDetail(title: "Weight", dimension: "20LBS"),
    ImageDetail(title: "Quantity", dimension: "1"),
  ];
}
