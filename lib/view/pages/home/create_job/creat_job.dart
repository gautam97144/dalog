import 'dart:convert';
import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/provider/drop_location_provider.dart';
import 'package:dalog_distribution/provider/pick_up_location.dart';
import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dalog_distribution/services/function.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../constant/constant.dart';
import '../../../../helper/shared_preferance.dart';
import '../../../../routs/app_routs.dart';
import '../../../../services/auth_service.dart';

class CreatJob extends StatefulWidget {
  CreatJob({Key? key}) : super(key: key);

  @override
  State<CreatJob> createState() => _CreatJobState();
}

class _CreatJobState extends State<CreatJob> with ValidationMixin {
  ValueNotifier<bool> isSelected = ValueNotifier(false);
  final formKey = GlobalKey<FormState>();
  final _formKey = GlobalKey<FormState>();
  PickupLocation? pickupLocation;

  final ValueNotifier<DateTime?> pickedDate = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> pickedTime = ValueNotifier(null);
  final ValueNotifier<DateTime?> dropOffDate = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> dropOffTime = ValueNotifier(null);

  final TextEditingController jobTitle = TextEditingController();
  final TextEditingController pickupAddress = TextEditingController();
  final TextEditingController pickupAddressTwo = TextEditingController();
  final TextEditingController state = TextEditingController();
  final TextEditingController pickUpLocation = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController zipCode = TextEditingController();
  final TextEditingController country = TextEditingController();
  final TextEditingController pickUpDateController = TextEditingController();
  final TextEditingController pickUpTimeController = TextEditingController();
  final TextEditingController dropOffTimeController = TextEditingController();
  final TextEditingController dropOffDateController = TextEditingController();

  final TextEditingController dropOffLocation = TextEditingController();
  final TextEditingController dropOffAddress = TextEditingController();
  final TextEditingController dropOffAddressTwo = TextEditingController();
  final TextEditingController dropOffZipCode = TextEditingController();
  final TextEditingController dropOffState = TextEditingController();
  final TextEditingController dropOffCity = TextEditingController();
  final TextEditingController dropOffCountry = TextEditingController();
  final TextEditingController specialInstruction = TextEditingController();
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
    // var userid = Provider.of<UserId>(context, listen: true).userId;
    return WillPopScope(
      onWillPop: () async {
        if (jobTitle.text == "" &&
            pickUpLocation.text == "" &&
            dropOffLocation.text == "" &&
            dropOffDateController.text == "" &&
            dropOffTimeController.text == "" &&
            pickUpTimeController.text == "" &&
            pickUpDateController.text == "") {
          CommonFunctions.toast("please enter at least one data");
        } else {
          await ApiService().createJob(context, data: data(context));
        }
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: SecondaryAppBar(
                isLeading: false,
                title: "Create Job",
                action: appText("1/3", style: AppTextStyle.greySubTitle)),
            body: SafeArea(
                child: Form(
              key: formKey,
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: PrimaryPadding(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        CustomSizedBox(),
                        SecondaryTextField(
                          controller: jobTitle,
                          hintText: "Job Title",
                          validator: jobTitleValidation,
                        ),
                        SizedBox(
                          height: Sizes.s30.h,
                        ),
                        appText("Select pickup location",
                            style: AppTextStyle.headingTextTile),
                        CustomSizedBox(),
                        SecondaryTextField(
                          readOnly: true,
                          controller: pickUpLocation,
                          validator: pickUpLocationValidation,
                          hintText: "Pickup location...",
                          onTap: () {
                            CustomBottomSheet.showBottomSheet(context, [
                              bottomSheet(
                                title: 'pickup location',
                                isInstruction: false,
                              )
                            ]);
                          },
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: pickedDate,
                              builder: (BuildContext context, DateTime? value,
                                  Widget? child) {
                                return Flexible(
                                    child: PrimaryTextField(
                                  validator: pickupDateValidation,
                                  readOnly: true,
                                  controller: pickUpDateController,
                                  hintText: pickedDate.value == null
                                      ? "Pick-up date"
                                      : pickUpDateController.text,
                                  // : FileUtils.getFormatDate(
                                  //     pickedDate.value.toString()),
                                  onTap: () async {
                                    pickedDate.value =
                                        await FileUtils.pickDate(context);
                                    pickUpDateController.text =
                                        FileUtils.getFormatDate(pickedDate.value
                                            .toString()); //   print(pickedDate.value);
                                  },
                                ));
                              },
                              //  child:
                            ),
                            SizedBox(
                              width: Sizes.s8.w,
                            ),
                            ValueListenableBuilder(
                              valueListenable: pickedTime,
                              builder: (BuildContext context, TimeOfDay? value,
                                  Widget? child) {
                                return Flexible(
                                    child: PrimaryTextField(
                                  controller: pickUpTimeController,
                                  validator: picupTimeValidation,
                                  hintText: pickedTime.value == null
                                      ? "Pick-up time"
                                      : pickUpTimeController.text,
                                  readOnly: true,
                                  onTap: () async {
                                    pickedTime.value =
                                        await FileUtils.pickTime(context);

                                    pickUpTimeController.text =
                                        pickedTime.value!.format(context);

                                    //print(pickedTime);
                                  },
                                ));
                              },
                            )
                          ],
                        ),
                        CustomSizedBox(),
                        orBanner(),
                        CustomSizedBox(),
                        asSoonAsContainer(),
                        CustomSizedBox(),
                        appText("Select drop-off location",
                            style: AppTextStyle.headingTextTile),
                        CustomSizedBox(),
                        SecondaryTextField(
                          controller: dropOffLocation,
                          validator: dropOffUpLocationValidation,
                          onTap: () {
                            CustomBottomSheet.showBottomSheet(context, [
                              bottomSheet(
                                title: "drop-off location",
                                isInstruction: true,
                              )
                            ]);
                          },
                          hintText: "drop-off location...",
                        ),
                        Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: dropOffDate,
                              builder: (BuildContext context, DateTime? value,
                                  Widget? child) {
                                return Flexible(
                                    child: PrimaryTextField(
                                        validator: pickupDateValidation,
                                        controller: dropOffDateController,
                                        readOnly: true,
                                        onTap: () async {
                                          dropOffDate.value =
                                              await FileUtils.pickDate(context);
                                          dropOffDateController.text =
                                              FileUtils.getFormatDate(
                                                  dropOffDate.value.toString());
                                        },
                                        hintText: dropOffDate.value == null
                                            ? "drop-off date"
                                            : dropOffDateController.text));
                              },
                            ),
                            SizedBox(
                              width: Sizes.s8.w,
                            ),
                            ValueListenableBuilder(
                              valueListenable: dropOffTime,
                              builder: (BuildContext context, TimeOfDay? value,
                                  Widget? child) {
                                return Flexible(
                                    child: PrimaryTextField(
                                  validator: picupTimeValidation,
                                  controller: dropOffTimeController,
                                  hintText: dropOffTime.value == null
                                      ? "drop-off time"
                                      : dropOffTimeController.text,
                                  onTap: () async {
                                    dropOffTime.value =
                                        await FileUtils.pickTime(context);

                                    dropOffTimeController.text =
                                        dropOffTime.value!.format(context);
                                  },
                                ));
                              },
                            )
                          ],
                        ),
                        CustomSizedBox(),
                        PrimaryButton(
                            lable: "Continue",
                            onPressed: () {
                              //Navigator.pushNamed(context, Routs.createJobSecond);
                              if (formKey.currentState!.validate()) {
                                print(
                                    'pickupAddressTwo.text --> ${pickupAddressTwo.text}');
                                Navigator.pushNamed(
                                    context, Routs.createJobSecond,
                                    arguments: CreateJobModel(
                                        jobTitle: jobTitle.text,
                                        pickUpLocation: pickUpLocation.text,
                                        pickUpDate: pickUpDateController.text,
                                        pickUpTime: pickUpTimeController.text,
                                        pickUpAddress: pickupAddress.text,
                                        pickUpAddressTwo: pickupAddressTwo.text,
                                        pickupCity: pickupAddressTwo.text,
                                        pickUpState: state.text,
                                        pickUpcountry: country.text,
                                        pickUpZipCode: zipCode.text,
                                        dropOffAddress: dropOffAddress.text,
                                        dropOffAddressTwo:
                                            dropOffAddressTwo.text,
                                        dropOffCity: dropOffCity.text,
                                        dropOffCountry: dropOffCountry.text,
                                        dropOffState: dropOffState.text,
                                        dropOffZipCode: dropOffZipCode.text,
                                        dropOffDate: dropOffDateController.text,
                                        dropOffTime: dropOffTimeController.text,
                                        dropOffLocation: dropOffLocation.text,
                                        instruction: specialInstruction.text));
                              }
                            }),
                        SizedBoxH10(),
                      ]))),
            ))),
      ),
    );
  }

  FormData data(BuildContext context) {
    return FormData.fromMap({
      "user_id": userId1!.replaceAll('"', '').replaceAll('"', '').toString(),
      "job_tittle": jobTitle.text,
      "pickup_location": pickUpLocation.text,
      "pickup_date": pickUpDateController.text,
      "pickup_time": pickUpTimeController.text,
      "pickup_address": pickupAddress.text,
      "pickup_address2": pickupAddressTwo.text,
      "pickup_city": pickupAddressTwo.text,
      "pickup_state": state.text,
      "pickup_zipcode": zipCode.text,
      "pickup_country": country.text,
      "pickup_lat": "",
      "pickup_long": "",
      "address": dropOffAddress.text,
      "address2": dropOffAddressTwo.text,
      "state": dropOffState.text,
      "city": dropOffCity.text,
      "zipcode": dropOffZipCode.text,
      "country": dropOffCountry.text,
      "drop_lat": "",
      "drop_long": "",
      "special_instructions": specialInstruction.text,
      "dropoffdate": dropOffDateController.text,
      "dropofftime": dropOffTimeController.text,
      "customize_item": jsonEncode([]),
      //addedImageData(context),
      "item_name": "",
      "item_value": '',
      "cost": '',
      "service_fees": '',
      "status": "2"
    });
  }

  Widget asSoonAsContainer() {
    return ValueListenableBuilder(
      valueListenable: isSelected,
      builder: (BuildContext context, bool value, Widget? child) {
        return GestureDetector(
          onTap: () {
            isSelected.value = !isSelected.value;
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: Sizes.s10.w),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: Sizes.s50.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                    color: isSelected.value == true
                        ? AppColor.red
                        : AppColor.lightGrey)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appText("As soon as possible",
                    style: AppTextStyle.blackSubTitle
                        .copyWith(fontWeight: FontWeight.w700)),
                CircleAvatar(
                  backgroundColor: isSelected.value == true
                      ? AppColor.red
                      : AppColor.lightGrey,
                  radius: Sizes.s16.r,
                  child: const Icon(
                    Icons.check,
                    color: AppColor.white,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget orBanner() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "-----",
          style: TextStyle(color: Colors.grey),
        ),
        Container(
          alignment: Alignment.center,
          width: Sizes.s30.w,
          height: Sizes.s30.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
          child: appText("OR",
              style:
                  AppTextStyle.greySubTitle.copyWith(fontSize: Sizes.s14.sp)),
        ),
        const Text("-----", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget selectDateAndTime() {
    return Row(
      children: [
        const Flexible(child: PrimaryTextField()),
        SizedBox(
          width: Sizes.s8.w,
        ),
        const Flexible(child: PrimaryTextField())
      ],
    );
  }

  Widget bottomSheet(
      {PickupLocation? data,
      String? controller,
      String? title,
      bool? isInstruction}) {
    // if (isInstruction == true) {
    //   clearController();
    // }
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBoxH28(),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            appText(title!, style: AppTextStyle.headingTextTile),
            const Expanded(child: SizedBox()),
            SvgPicture.asset(
              AppAsset.mapIcon,
              height: Sizes.s14.h,
              width: Sizes.s14.w,
            ),
            SizedBoxW8(),
            appText("Current Location",
                style:
                    AppTextStyle.redTextStyle.copyWith(fontSize: Sizes.s12.sp))
          ]),
          SizedBoxH28(),
          SecondaryTextField(
            controller: isInstruction == true ? dropOffAddress : pickupAddress,
            hintText: "Address",
            validator: addressValidation,
            maxLines: 3,
            color:
                Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
          ),
          SecondaryTextField(
              controller:
                  isInstruction == true ? dropOffAddressTwo : pickupAddressTwo,
              hintText: "Address 2",
              maxLines: 3,
              validator: addressValidation,
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : AppColor.lightGrey),
          Row(
            children: [
              Flexible(
                  child: PrimaryTextField(
                      validator: cityValidation,
                      controller: isInstruction == true ? dropOffCity : city,
                      hintText: 'City',
                      color: Theme.of(context).brightness ==
                              ThemeUtils.darkTheme.brightness
                          ? AppColor.darkThemeScaffoldBackground
                          : AppColor.lightGrey)),
              SizedBox(width: Sizes.s8.w),
              Flexible(
                  child: PrimaryTextField(
                      controller: isInstruction == true ? dropOffState : state,
                      validator: stateValidation,
                      color: Theme.of(context).brightness ==
                              ThemeUtils.darkTheme.brightness
                          ? AppColor.darkThemeScaffoldBackground
                          : AppColor.lightGrey,
                      hintText: "State"))
            ],
          ),
          Row(
            children: [
              Flexible(
                  child: PrimaryTextField(
                validator: zipCodeValidation,
                controller: isInstruction == true ? dropOffZipCode : zipCode,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                hintText: "Zip Code",
              )),
              SizedBox(width: Sizes.s8.w),
              Flexible(
                  child: PrimaryTextField(
                validator: countryValidation,
                controller: isInstruction == true ? dropOffCountry : country,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                hintText: "Country",
              ))
            ],
          ),
          SizedBoxH28(),
          isInstruction == true
              ? appText("Special Instructions",
                  style: AppTextStyle.headingTextTile)
              : const SizedBox.shrink(),
          isInstruction == true ? SizedBoxH28() : const SizedBox.shrink(),
          isInstruction == true
              ? SecondaryTextField(
                  controller: specialInstruction,
                  color: Theme.of(context).brightness ==
                          ThemeUtils.darkTheme.brightness
                      ? AppColor.darkThemeScaffoldBackground
                      : AppColor.lightGrey,
                  hintText: "Instruction here...",
                )
              : const SizedBox.shrink(),
          PrimaryButton(
              lable: "Done",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isInstruction != true) {
                    Provider.of<LocationProvider>(context, listen: false)
                        .setAddress(
                            pickupLocation: PickupLocation(
                      address: pickupAddress.text,
                      addressTwo: pickupAddressTwo.text,
                      city: city.text,
                      state: state.text,
                      country: country.text,
                      zipCode: zipCode.text,
                    ));

                    pickUpLocation.text =
                        Provider.of<LocationProvider>(context, listen: false)
                            .pickUpLocationData!;
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  } else {
                    Provider.of<DropOffLocationProvider>(context, listen: false)
                        .setAddress(
                            pickupLocation: PickupLocation(
                      address: dropOffAddress.text,
                      addressTwo: dropOffAddressTwo.text,
                      city: dropOffCity.text,
                      state: dropOffState.text,
                      country: dropOffCountry.text,
                      zipCode: dropOffZipCode.text,
                    ));

                    dropOffLocation.text = Provider.of<DropOffLocationProvider>(
                            context,
                            listen: false)
                        .pickUpLocationData!;
                    Navigator.pop(context);
                    FocusScope.of(context).unfocus();
                  }
                }
              }),
          SizedBoxH10()
        ],
      ),
    );
  }

  void clearController() {
    pickupAddress.clear();
    pickupAddressTwo.clear();
    city.clear();
    zipCode.clear();
    state.clear();
    country.clear();
  }
}

// class BottomSheet extends StatefulWidget {
//   String title;
//   bool? isInstruction;
//   String? adress;
//
//   BottomSheet({Key? key, required this.title, this.adress,this.isInstruction})
//       : super(key: key);
//
//   @override
//   State<BottomSheet> createState() => _BottomSheetState();
// }
//
// class _BottomSheetState extends State<BottomSheet> {
//
//   TextEditingController address = TextEditingController();
//
//   TextEditingController addressTwo = TextEditingController();
//
//   TextEditingController city =TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//   }
// }

class PickupLocation {
  String? address;
  String? addressTwo;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  PickupLocation(
      {this.address,
      this.addressTwo,
      this.city,
      this.state,
      this.zipCode,
      this.country});
}
