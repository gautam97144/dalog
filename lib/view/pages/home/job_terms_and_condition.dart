import 'dart:convert';
import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/provider/image_data.dart';
import 'package:dalog_distribution/provider/user_id_provider.dart';
import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/services/function.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/pages/home/create_job/create_job_second/create_job_second.dart';
import 'package:dalog_distribution/view/pages/home/my_listing.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../helper/shared_preferance.dart';
import '../../../routs/app_routs.dart';

class JobTermsAndCondition extends StatefulWidget {
  CreateJobSecondModel? arguments;
  JobTermsAndCondition(this.arguments, {Key? key}) : super(key: key);

  @override
  State<JobTermsAndCondition> createState() => _JobTermsAndConditionState();
}

class _JobTermsAndConditionState extends State<JobTermsAndCondition> {
  ValueNotifier<bool> isChecked = ValueNotifier(false);

  List<AddItem>? provider;

  String? userId1 = '';

  getUserId() async {
    userId1 = await Preferances.getString("userid");
    setState(() {});
    print(
        'user id ${userId1!.replaceAll('"', '').replaceAll('"', '').toString()}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ImageData>(context, listen: false).addedItem;
    //  var userId = Provider.of<UserId>(context, listen: true).userId;
    // print("userId ->$userId");
    print(provider.length);
    return WillPopScope(
      onWillPop: () async => await ApiService().createJob(context,
          data: data(context,
              userId1!.replaceAll('"', '').replaceAll('"', '').toString())),
      child: Stack(alignment: Alignment.bottomCenter, children: [
        Scaffold(
          appBar: SecondaryAppBar(
            title: "Create Job",
            action: InkWell(
                onTap: () {
                  //   print('addedImageData.toString() ---> ${addedImageData(context).toString()}');
                },
                child: appText("3/3", style: AppTextStyle.greySubTitle)),
          ),
          body: CustomScroll(
            children: [
              CustomSizedBox(),
              appText("Terms & Conditions",
                  style: AppTextStyle.headingTextTile2),
              appText(
                  "This T&C sets out how we collect, use,communicate, disclose and otherwise make use of personal information provided by users of this website.",
                  softWrap: true,
                  style: AppTextStyle.greySubTitle),
              appText("Information Collection, Use & Sharing",
                  style: AppTextStyle.headingTextTile2
                      .copyWith(fontWeight: FontWeight.w400)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appText(
                    "1",
                    style: AppTextStyle.greySubTitle,
                  ),
                  SizedBoxW10(),
                  Expanded(
                    child: appText(
                        "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium, totam rem aperiam, eaque ipsa quae ab",
                        softWrap: true,
                        style: AppTextStyle.greySubTitle),
                  )
                ],
              ),
              SizedBoxH10(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText("2", style: AppTextStyle.greySubTitle),
                  SizedBoxW10(),
                  Expanded(
                    child: appText(
                        "I must explain to you how all this mistake idea of denouncing pleasure.",
                        softWrap: true,
                        style: AppTextStyle.greySubTitle),
                  )
                ],
              ),
              appText("Security",
                  style: AppTextStyle.headingTextTile2
                      .copyWith(fontWeight: FontWeight.w400)),
              appText(
                  "We take precautions to protect your. When you submit your information via this website,your information is protected both online",
                  softWrap: true,
                  style: AppTextStyle.greySubTitle),
            ],
          ),
        ),
        confirmTermsAndConditionBox(context,
            userId1!.replaceAll('"', '').replaceAll('"', '').toString())
      ]),
    );
  }

  // ======================== widget ============================//
  List<Map<String, dynamic>> addedImageData(BuildContext context) {
    provider = Provider.of<ImageData>(context, listen: false).addedItem;
    List<Map<String, dynamic>> imageList = [];

    ///print('provider!.length --> ${provider!.length}');
    for (int i = 0; i < provider!.length; i++) {
      Map<String, dynamic> map = {};
      map['image'] = provider?[i].itemImage;
      map['itemName'] = provider?[i].itemName;
      map['quantity'] = provider?[i].quantity;
      map['length'] = provider?[i].length;
      map['width'] = provider?[i].width;
      map['height'] = provider?[i].height;
      map['weight'] = provider?[i].weight;
      imageList.add(map);
    }
    return imageList;
  }

  Widget confirmTermsAndConditionBox(BuildContext context, String userid) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: ScreenUtil().screenHeight / 4,
        width: ScreenUtil().screenWidth,
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius))),
        child: PrimaryPadding(
          verticalPadding: Sizes.s10.h,
          child: Column(children: [
            Row(
              children: [
                ValueListenableBuilder(
                  valueListenable: isChecked,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return InkWell(
                        onTap: () {
                          isChecked.value = !isChecked.value;
                        },
                        child: isChecked.value == false
                            ? CircleAvatar(
                                backgroundColor: Theme.of(context).brightness ==
                                        ThemeUtils.darkTheme.brightness
                                    ? AppColor.darkThemeScaffoldBackground
                                    : AppColor.darkGrey,
                                radius: Sizes.s16.r,
                              )
                            : SmallRedCircularIcon());
                  },
                ),
                SizedBoxW10(),
                appText("Prefer driver to contact you by phone",
                    style: AppTextStyle.blackSubTitle
                        .copyWith(fontWeight: FontWeight.w700))
              ],
            ),
            SizedBoxH14(),
            PrimaryButton(
                lable: "Post a Job",
                onPressed: () async {
                  if (isChecked.value == true) {
                    await ApiService()
                        .createJob(context, data: data(context, userid))
                        .then((value) {
                      CustomDialog.dialogShow(context,
                          children: [column(context)]);
                    });
                  } else {
                    CommonFunctions.toast("Please accept terms and condition");
                  }
                }),
            SizedBoxH14(),
            appText(
                "By clicking “Post a Job” you are agree to over Terms & Conditions ",
                softWrap: true,
                style: AppTextStyle.subTitle2
                    .copyWith(color: AppColor.primaryColor),
                textAlign: TextAlign.center)
          ]),
        ),
      ),
    );
  }

  //************************ alert Dialog(succeesful post) ***********************//
  FormData data(BuildContext context, String userid) {
    return FormData.fromMap({
      "user_id": userid,
      "job_tittle": widget.arguments?.createJobModel?.jobTitle,
      "pickup_location": widget.arguments?.createJobModel?.pickUpLocation,
      "pickup_date": widget.arguments?.createJobModel?.pickUpDate,
      "pickup_time": widget.arguments?.createJobModel?.dropOffTime,
      "pickup_address": widget.arguments?.createJobModel?.pickUpAddress,
      "pickup_address2": widget.arguments?.createJobModel?.pickUpAddressTwo,
      "pickup_city": widget.arguments?.createJobModel?.pickupCity,
      "pickup_state": widget.arguments?.createJobModel?.pickUpState,
      "pickup_zipcode": widget.arguments?.createJobModel?.pickUpZipCode,
      "pickup_country": widget.arguments?.createJobModel?.pickUpcountry,
      "pickup_lat": "",
      "pickup_long": "",
      "address": widget.arguments?.createJobModel?.dropOffAddress,
      "address2": widget.arguments?.createJobModel?.dropOffAddressTwo,
      "state": widget.arguments?.createJobModel?.dropOffState,
      "city": widget.arguments?.createJobModel?.dropOffCity,
      "zipcode": widget.arguments?.createJobModel?.dropOffZipCode,
      "country": widget.arguments?.createJobModel?.dropOffCountry,
      "drop_lat": "",
      "drop_long": "",
      "special_instructions": widget.arguments?.createJobModel?.instruction,
      "dropoffdate": widget.arguments?.createJobModel?.dropOffDate,
      "dropofftime": widget.arguments?.createJobModel?.dropOffTime,
      "customize_item": jsonEncode(addedImageData(context)),
      "item_name": "",
      "item_value": widget.arguments?.totalValue,
      "cost": widget.arguments?.estimateCost,
      "service_fees": widget.arguments?.serviceFees,
      "status": "1"
    });
  }

  Column column(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppAsset.checkSuccessfully,
          // height: Sizes.s30.h,
          // width: Sizes.s30.h,
        ),
        SizedBoxW10(),
        appText('Successfully Posted', style: AppTextStyle.headingTextTile),
        SizedBoxW10(),
        appText("We’ll assign the driver soon for the pickup and delivery.",
            textAlign: TextAlign.center,
            softWrap: true,
            style: AppTextStyle.alertSubtitle),
        SizedBoxH10(),
        PrimaryButton(
            height: Sizes.s46.h,
            lable: "Back to my listings",
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routs.bottomNavigation);
            })
      ],
    );
  }
}
