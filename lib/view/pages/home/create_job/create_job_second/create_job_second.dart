import 'dart:convert';
import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/helper/shared_preferance.dart';
import 'package:dalog_distribution/models/uploadImage.dart';
import 'package:dalog_distribution/provider/image_data.dart';
import 'package:dalog_distribution/routs/arguments.dart';
import 'package:dalog_distribution/services/api_endpoints.dart';
import 'package:dalog_distribution/services/auth_service.dart';
import 'package:dalog_distribution/services/function.dart';
import 'package:dalog_distribution/utils/utils.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:dio/dio.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import '../../../../../constant/app_text_style.dart';
import '../../../../../models/debit_card.dart';
import '../../../../../models/product_diamension.dart';
import '../../../../../routs/app_routs.dart';

class CreatJobSecond extends StatefulWidget {
  CreateJobModel? arguments;
  CreatJobSecond(this.arguments, {Key? key}) : super(key: key);

  @override
  State<CreatJobSecond> createState() => _CreatJobSecondState();
}

class _CreatJobSecondState extends State<CreatJobSecond> with ValidationMixin {
  final ValueNotifier<int> _index = ValueNotifier(0);
  final ValueNotifier<bool> _isOpen = ValueNotifier(false);
  final ValueNotifier<int> index = ValueNotifier(0);
  final _formKey = GlobalKey<FormState>();

  UploadImage? uploadImage;
  bool isOpen = false;
  bool isBottomSheetOpen = true;
  int? selectedIndex = 0;

  List<String> imageInfoList = [
    'Length',
    'Width',
    'Height',
    'Weight',
  ];
  String isSelected = 'Length';

  final ValueNotifier<List<CategoryName>> _categoryName = ValueNotifier([
    CategoryName(name: "Furniture", isSelected: false),
    CategoryName(name: "Clothing", isSelected: false),
    CategoryName(name: "Grocery", isSelected: false),
    CategoryName(name: "Luggage", isSelected: false),
    CategoryName(name: "Medical Equipment", isSelected: false)
  ]);

  final ValueNotifier<File?> _file = ValueNotifier(null);

  TextEditingController itemNameController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController quantityController1 = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController estimatedCostController = TextEditingController();
  TextEditingController totalItemValue = TextEditingController();
  TextEditingController serviceFeesController = TextEditingController();
  TextEditingController totalCost = TextEditingController();

  final ScrollController controller = ScrollController();
  double currentPosition = 0.0;
  final int totalDotsCount = 4;
  final formKey = GlobalKey<FormState>();

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
    //widget.arguments?.dropOffCity;
    print(
        'widget.arguments --> ${widget.arguments!.pickUpAddressTwo.toString()}');
    final provider =
        Provider.of<ImageData>(context, listen: true).addedItem.length;
    return WillPopScope(
      onWillPop: () async =>
          await ApiService().createJob(context, data: dataDraftSave(context)),
      child: Scaffold(
          appBar: SecondaryAppBar(
            title: "Create Job",
            action: appText(
              "2/3",
              style: AppTextStyle.greySubTitle,
            ),
          ),
          body: Form(
            key: formKey,
            child: CustomScroll(
              children: [
                CustomSizedBox(),
                appText("Choose category of items",
                    style: AppTextStyle.headingTextTile),
                horizontalCategoryList(),
                Provider.of<ImageData>(context, listen: true).addItem == null
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(borderRadius),
                              color: Theme.of(context).cardColor,
                              border: RDottedLineBorder.all(
                                color: Colors.grey,
                                width: 1,
                              )),
                          width: ScreenUtil().screenWidth / 1.2,
                          height: Sizes.s120.h,
                          child: uploadButtonAndLable(),
                        ),
                      )
                    //  :
                    //OutPutLuggage(),
                    : SizedBox(
                        height: provider == 0
                            ? Sizes.s120.h
                            : ScreenUtil().screenWidth / 1.2,
                        //width: ScreenUtil().screenWidth - Sizes.s16.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              Provider.of<ImageData>(context, listen: true)
                                      .addedItem
                                      .length +
                                  1,
                          itemBuilder: (BuildContext context, int index) {
                            if (Provider.of<ImageData>(context, listen: true)
                                    .addedItem
                                    .length ==
                                index) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(borderRadius),
                                    color: Theme.of(context).cardColor,
                                    border: RDottedLineBorder.all(
                                      color: Colors.grey,
                                      width: 1,
                                    )),
                                width: ScreenUtil().screenWidth / 1.2,
                                height: Sizes.s120.h,
                                child: uploadButtonAndLable(),
                              );
                            }
                            return Padding(
                              padding: EdgeInsets.only(right: Sizes.s10.w),
                              child: OutPutLuggage(
                                  Provider.of<ImageData>(context, listen: true)
                                      .addedItem[index],
                                  index),
                            );
                          },
                        ),
                      ),
                //slidingImage(),
                indicator(),
                SizedBoxH28(),
                appText("Total item value",
                    style: AppTextStyle.headingTextTile),
                SizedBoxH14(),
                PrimaryTextField(
                  keyboardInputType: TextInputType.number,
                  validator: totalValue,
                  controller: totalItemValue,
                  hintText: "\$100",
                ),
                // PrimaryTextField(
                //   readOnly: true,
                //   hintText: "\$100 - \$200",
                //   suffix: InkWell(
                //     onTap: () {
                //       _isOpen.value = !_isOpen.value;
                //     },
                //     child: const Icon(
                //       Icons.keyboard_arrow_down_outlined,
                //       color: AppColor.primaryColor,
                //     ),
                //   ),
                // ),

                // ValueListenableBuilder(
                //   valueListenable: _isOpen,
                //   builder: (BuildContext context, bool? value, Widget? child) {
                //     return _isOpen.value == true
                //         ? Container(
                //             padding: EdgeInsets.symmetric(vertical: Sizes.s10.h),
                //             width: ScreenUtil().screenWidth,
                //             decoration: BoxDecoration(
                //                 color: AppColor.lightGrey,
                //                 borderRadius: BorderRadius.circular(20)),
                //             child: Column(
                //               children: [
                //                 appText("\$100-\$200"),
                //                 SizedBoxH10(),
                //                 appText("\$200-\$300"),
                //                 SizedBoxH10(),
                //                 appText("\$300-\$400"),
                //                 SizedBoxH10(),
                //                 appText("\$400-\$500"),
                //               ],
                //             ),
                //           )
                //         : const SizedBox.shrink();
                //   },
                // ),

                // ValueListenableBuilder(
                //   valueListenable: _isOpen,
                //   builder: (BuildContext context, bool value, Widget? child) {
                //     return Visibility(
                //         visible: isOpen,
                //         child:
                //     );
                //   },
                //   //child:
                // ),

                SizedBoxH28(),
                appText("Estimated Cost", style: AppTextStyle.headingTextTile),
                appText(
                    "Based on the size and location of the pickup and delivery the cost will be estimated",
                    softWrap: true,
                    style: AppTextStyle.greySubTitle),
                SizedBoxH14(),
                PrimaryTextField(
                  keyboardInputType: TextInputType.number,
                  hintText: "\$500",
                  validator: estimatedCost,
                  controller: estimatedCostController,
                ),
                // PriceBox(
                //   title: "\$500",
                // ),
                SizedBoxH28(),
                appText("Service Fees", style: AppTextStyle.headingTextTile),
                SizedBoxH14(),
                PrimaryTextField(
                  keyboardInputType: TextInputType.number,
                  hintText: "\$50",
                  validator: serviceFees,
                  controller: serviceFeesController,
                ),
                SizedBoxH28(),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appText("Add Credit Card",
                          style: AppTextStyle.headingTextTile),
                      addMoreButton()
                    ]),
                SizedBoxH10(),
                appText(
                    "\$1 test payment will be charged and will be reversed the amount and card details will be saved and after the delivery, the card will be charged.",
                    softWrap: true,
                    style: AppTextStyle.greySubTitle),
                SizedBoxH14(),
                debitCardWidget(),
                SizedBoxH28(),
                PrimaryButton(
                    lable: "Continue",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (provider == 0) {
                          CommonFunctions.toast("Please upload your image");
                        } else {
                          Navigator.pushNamed(context, Routs.termsAndCondition,
                              arguments: CreateJobSecondModel(
                                itemName: itemNameController.text,
                                serviceFees: serviceFeesController.text,
                                totalValue: totalItemValue.text,
                                estimateCost: estimatedCostController.text,
                                createJobModel: widget.arguments,
                              ));
                        }
                      }
                    }),
                SizedBoxH10(),
              ],
            ),
          )),
    );
  }

  FormData dataDraftSave(BuildContext context) {
    return FormData.fromMap({
      "user_id": userId1!.replaceAll('"', '').replaceAll('"', '').toString(),
      "job_tittle": widget.arguments?.jobTitle,
      "pickup_location": widget.arguments?.pickUpLocation,
      "pickup_date": widget.arguments?.pickUpDate,
      "pickup_time": widget.arguments?.dropOffTime,
      "pickup_address": widget.arguments?.pickUpAddress,
      "pickup_address2": widget.arguments?.pickUpAddressTwo,
      "pickup_city": widget.arguments?.pickupCity,
      "pickup_state": widget.arguments?.pickUpState,
      "pickup_zipcode": widget.arguments?.pickUpZipCode,
      "pickup_country": widget.arguments?.pickUpcountry,
      "pickup_lat": "",
      "pickup_long": "",
      "address": widget.arguments?.dropOffAddress,
      "address2": widget.arguments?.dropOffAddressTwo,
      "state": widget.arguments?.dropOffState,
      "city": widget.arguments?.dropOffCity,
      "zipcode": widget.arguments?.dropOffZipCode,
      "country": widget.arguments?.dropOffCountry,
      "drop_lat": "",
      "drop_long": "",
      "special_instructions": widget.arguments?.instruction,
      "dropoffdate": widget.arguments?.dropOffDate,
      "dropofftime": widget.arguments?.dropOffTime,
      "customize_item": jsonEncode([]),
      "item_name": itemNameController.text,
      "item_value": totalItemValue.text,
      "cost": estimatedCostController.text,
      "service_fees": serviceFeesController.text,
      "status": "2"
    });
  }

  //=========================== ALl widget==========================//

  //********************** debit card ===================//

  //********************** add more button ===================//

  Container debitCardWidget() {
    return Container(
        color: Colors.transparent,
        height: Sizes.s90.h,
        width: double.infinity,
        child: ListView.builder(
            //   shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: debitCard.value.length,
            itemBuilder: (context, index) {
              return Row(children: [
                ValueListenableBuilder(
                    valueListenable: debitCard,
                    builder: (BuildContext context, value, Widget? child) {
                      return GestureDetector(
                        onTap: () {
                          debitCardSelection(index);
                        },
                        child: DebitCardBox(
                          width: ScreenUtil().screenWidth / 1.5,
                          title: debitCard.value[index].name.toString(),
                          leading: selectionIcon(index),
                          trailing:
                              debitCard.value[index].expiryDate.toString(),
                          subTitle: debitCard.value[index].cardNo.toString(),
                        ),
                      );
                    }),
                SizedBox(
                  width: Sizes.s5.w,
                )
              ]);
            }));
  }

  Widget addMoreButton() {
    return Row(
      children: [
        appText("Add New",
            style: AppTextStyle.redTextStyle
                .copyWith(fontWeight: FontWeight.w700)),
        SizedBox(
          width: Sizes.s7.w,
        ),
        CircularRedButton(
            child: const Icon(
          Icons.add,
          color: AppColor.white,
        ))
      ],
    );
  }

  //************************* selection Icon ************************//

  Widget selectionIcon(int index) {
    return CircleAvatar(
        backgroundColor: debitCard.value[index].isSelected == true
            ? AppColor.red
            : (Theme.of(context).brightness == ThemeUtils.darkTheme.brightness)
                ? AppColor.darkThemeScaffoldBackground
                : AppColor.lightGrey,
        radius: Sizes.s16.r,
        child: debitCard.value[index].isSelected == true
            ? const Icon(
                Icons.check,
                color: AppColor.white,
              )
            : null);
  }

  //*********************** horizontal category List *****************//

  Widget horizontalCategoryList() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
          controller: controller,
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
                            color: Theme.of(context).dialogBackgroundColor,
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
                                    fontSize: Sizes.s16.sp)
                                : AppTextStyle.greySubTitle
                                    .copyWith(fontSize: Sizes.s16.sp))),
                  );
                },
              ),
            ]);
          }),
    );
  }

  //*********************** sliding image horizontal  *****************//

  Widget slidingImage() {
    return SizedBox(
      height: Sizes.s160.h,
      //width: double.infinity,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Row(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: Theme.of(context).cardColor,
                    border: RDottedLineBorder.all(
                      color: Colors.grey,
                      width: 1,
                    )),
                width: ScreenUtil().screenWidth / 1.2,
                height: Sizes.s120.h,
                child: uploadButtonAndLable(),
              ),
              SizedBox(
                width: Sizes.s10.w,
              )
            ]);
          }),
    );
  }

  //*************************** upload red Button And Lable *********** //

  Widget uploadButtonAndLable() {
    return GestureDetector(
      onTap: () {
        if (isBottomSheetOpen == true) {
          clearData();
          CustomBottomSheet.showBottomSheet(context, [bottomSheet()]);
        }
      },
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        CircularRedButton(
          child: Padding(
            padding: EdgeInsets.all(Sizes.s9.h),
            child: SvgPicture.asset(AppAsset.uploadIcon),
          ),
        ),
        SizedBoxW10(),
        appText("Customize your Item",
            softWrap: true, style: AppTextStyle.blackSubTitle),
      ]),
    );
  }

  // ************************* model bottom sheet ***********************//

  Widget bottomSheet() {
    if (quantityController.text != "") {
      quantityController.clear();
    }

    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState1) {
      return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBoxH28(),
          appText("Add items image", style: AppTextStyle.headingTextTile),
          SizedBoxH14(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ValueListenableBuilder(
              valueListenable: _file,
              builder: (BuildContext context, File? value, Widget? child) {
                return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: Theme.of(context).brightness ==
                                ThemeUtils.darkTheme.brightness
                            ? AppColor.darkThemeScaffoldBackground
                            : AppColor.lightGrey,
                        border: RDottedLineBorder.all(
                          color: Colors.grey,
                          width: 1,
                        )),
                    width: ScreenUtil().screenWidth / 1.2,
                    height: Sizes.s120.h,
                    child: _file.value == null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              imageSourceButton(1, AppAsset.camera),
                              SizedBoxW10(),
                              imageSourceButton(2, AppAsset.gallery),
                            ],
                          )
                        : Image.file(_file.value!));
              },
              //child:
            ),
          ]),
          SizedBoxH28(),
          appText("Enter Item name & Quantities",
              style: AppTextStyle.headingTextTile),
          SizedBoxH14(),
          PrimaryTextField(
            validator: itemNameValidation,
            color:
                Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
            hintText: "Item Name",
            controller: itemNameController,
          ),
          PrimaryTextField(
            keyboardInputType: TextInputType.number,
            validator: quantityValidation,
            hintText: "Quantities",
            color:
                Theme.of(context).brightness == ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
            controller: quantityController,
          ),
          SizedBox(
            width: double.infinity,
            height: Sizes.s50.h,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: imageInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                // selectedIndex = index;
                return GestureDetector(
                  onTap: () {
                    setState1(() {
                      isSelected = imageInfoList[index].toString();
                    });
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                      padding: EdgeInsets.symmetric(horizontal: Sizes.s6.w),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Theme.of(context).brightness ==
                                  ThemeUtils.darkTheme.brightness
                              ? AppColor.darkThemeScaffoldBackground
                              : Colors.transparent,
                          border: Border.all(
                              color: imageInfoList[index] == isSelected
                                  ? AppColor.red
                                  : AppColor.darkGrey),
                          borderRadius: BorderRadius.circular(20)),
                      child: appText(imageInfoList[index].toString(),
                          style: imageInfoList[index] == isSelected
                              ? AppTextStyle.subTitle2.copyWith(
                                  fontWeight: FontWeight.w800,
                                )
                              : AppTextStyle.greySubTitle
                                  .copyWith(fontSize: Sizes.s14.sp))),
                );

                // return ValueListenableBuilder(
                //   valueListenable: diamension,
                //   builder: (BuildContext context, List<Diamension> value,
                //       Widget? child) {
                //     return GestureDetector(
                //       onTap: () {
                //         _updateDiamension(index);
                //       },
                //       child: Container(
                //           margin: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                //           padding: EdgeInsets.symmetric(horizontal: Sizes.s5.w),
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //               color: Theme.of(context).brightness ==
                //                       ThemeUtils.darkTheme.brightness
                //                   ? AppColor.darkThemeScaffoldBackground
                //                   : Colors.transparent,
                //               border: Border.all(
                //                   color:
                //                       diamension.value[index].isSelected == true
                //                           ? AppColor.red
                //                           : AppColor.darkGrey),
                //               borderRadius: BorderRadius.circular(20)),
                //           child: appText(diamension.value[index].name.toString(),
                //               style: diamension.value[index].isSelected == true
                //                   ? AppTextStyle.subTitle2.copyWith(
                //                       fontWeight: FontWeight.w800,
                //                     )
                //                   : AppTextStyle.greySubTitle
                //                       .copyWith(fontSize: Sizes.s14.sp))),
                //     );
                //   },
                // );
              },
            ),
          ),
          SizedBoxH14(),
          diamensionRow(isSelected),
          SizedBoxH14(),
          // Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [addMoreButton()]),
          SizedBoxH14(),
          PrimaryButton(
            lable: "Done",
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (_file.value == null) {
                  CommonFunctions.toast("please select image");
                } else {
                  FormData data = FormData.fromMap({
                    "image": await MultipartFile.fromFile(_file.value!.path)
                  });
                  uploadImage =
                      await ApiService().uploadImage(context, data: data);
                  await Provider.of<ImageData>(context, listen: false)
                      .setImageData(
                          addItem: AddItem(
                    itemName: itemNameController.text,
                    quantity: quantityController.text,
                    itemImage: uploadImage?.filepathUrl,
                    length: lengthController.text,
                    width: widthController.text,
                    height: heightController.text,
                    weight: weightController.text,
                  ));

                  Navigator.pop(context);
                }
              }
            },
          ),
          SizedBoxH10()
        ]),
      );
    });
  }

  //******************* camera button ********************//
  //'Length','Width','Height','Weight','Quantity'
  Widget diamensionRow(String name) {
    if (name == 'Length') {
      return Row(
        children: [
          Flexible(
            child: PrimaryTextField(
                keyboardInputType: TextInputType.number,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                controller: lengthController,
                hintText: "Length"),
          ),
          SizedBoxW8(),
          Flexible(
            child: PrimaryTextField(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : AppColor.lightGrey,
              readOnly: true,
              hintText: "Feet",
            ),
          )
        ],
      );
    } else if (name == 'Width') {
      return Row(
        children: [
          Flexible(
            child: PrimaryTextField(
                keyboardInputType: TextInputType.number,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                controller: widthController,
                hintText: "Width"),
          ),
          SizedBoxW8(),
          Flexible(
            child: PrimaryTextField(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : AppColor.lightGrey,
              readOnly: true,
              hintText: "Feet",
            ),
          )
        ],
      );
    } else if (name == 'Height') {
      return Row(
        children: [
          Flexible(
            child: PrimaryTextField(
                keyboardInputType: TextInputType.number,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                controller: heightController,
                hintText: "Height"),
          ),
          SizedBoxW8(),
          Flexible(
            child: PrimaryTextField(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : AppColor.lightGrey,
              readOnly: true,
              hintText: "Feet",
            ),
          )
        ],
      );
    } else if (name == 'Weight') {
      return Row(
        children: [
          Flexible(
            child: PrimaryTextField(
                keyboardInputType: TextInputType.number,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                controller: weightController,
                hintText: "Weight"),
          ),
          SizedBoxW8(),
          Flexible(
            child: PrimaryTextField(
              readOnly: true,
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : AppColor.lightGrey,
              hintText: "Pound",
            ),
          )
        ],
      );
    } else {
      return Row(
        children: [
          Flexible(
            child: PrimaryTextField(
                keyboardInputType: TextInputType.number,
                color: Theme.of(context).brightness ==
                        ThemeUtils.darkTheme.brightness
                    ? AppColor.darkThemeScaffoldBackground
                    : AppColor.lightGrey,
                controller: widthController,
                hintText: "Width"),
          ),
          SizedBoxW8(),
          Flexible(
            child: PrimaryTextField(
              color: Theme.of(context).brightness ==
                      ThemeUtils.darkTheme.brightness
                  ? AppColor.darkThemeScaffoldBackground
                  : AppColor.lightGrey,
              readOnly: true,
              hintText: "Feet",
            ),
          )
        ],
      );
    }
  }

  Widget imageSourceButton(int status, String assetName) {
    return GestureDetector(
      onTap: () async {
        if (status == 1) {
          File? file = await FileUtils.permissionHanDle(1);
          _file.value = file;
        } else {
          File? file = await FileUtils.permissionHanDle(2);
          _file.value = file;
        }
      },
      child: CircleAvatar(
        backgroundColor: AppColor.red,
        radius: Sizes.s22.r,
        child: Padding(
          padding: EdgeInsets.all(Sizes.s6.h),
          child: SvgPicture.asset(assetName),
        ),
      ),
    );
  }

  //******************** indicator ****************//

  Widget indicator() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      DotsIndicator(
          position: currentPosition,
          axis: Axis.horizontal,
          decorator: const DotsDecorator(
              activeColor: AppColor.primaryColor, color: AppColor.darkGrey),
          mainAxisAlignment: MainAxisAlignment.center,
          reversed: true,
          onTap: (position) {
            setState(() {
              currentPosition = position;
            });
          },
          dotsCount: totalDotsCount),
    ]);
  }

  //======================== function =======================//

  void _updateCategory(int index) {
    _categoryName.value[index].isSelected =
        !_categoryName.value[index].isSelected;
    _categoryName.notifyListeners();
  }

  void debitCardSelection(int index) {
    for (DebitCardData element in debitCard.value) {
      element.isSelected = false;
    }
    debitCard.value[index].isSelected = true;

    debitCard.notifyListeners();
  }

  void _updateDiamension(int index) {
    for (var element in diamension.value) {
      element.isSelected = false;
    }
    diamension.value[index].isSelected = true;
    // _textFeildData[index + 1];

    diamension.notifyListeners();
  }

  void clearData() {
    quantityController.clear();
    itemNameController.clear();
    _file.value = null;
    lengthController.clear();
    widthController.clear();
    weightController.clear();
    heightController.clear();
    for (var element in diamension.value) {
      element.isSelected = false;
    }
  }
}

class CategoryName {
  String? name;
  bool isSelected;
  CategoryName({this.name, required this.isSelected});
}

class OutPutLuggage extends StatelessWidget {
  AddItem? addedItem;
  int? index;
  OutPutLuggage(
    this.addedItem,
    this.index, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageData>(builder: (context, value, child) {
      return Stack(children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: Sizes.s12.h),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenWidth / 1.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              appText(addedItem!.itemName!,
                  style: AppTextStyle.headingTextTile),
              Stack(children: [
                Container(
                  height: ScreenUtil().screenWidth / 2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(EndPoints.imageUrl +
                              addedItem!.itemImage.toString())
                          // FileImage(
                          //     File(addedItem!.itemImage.toString()))
                          )),
                ),
                Positioned.fill(
                    child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(Sizes.s10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: CircleAvatar(
                            radius: Sizes.s16.r,
                            backgroundColor: AppColor.white,
                            child: const Icon(
                              Icons.edit,
                              color: AppColor.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Sizes.s3.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Provider.of<ImageData>(context, listen: false)
                                .removeImageData(index!);
                          },
                          child: CircleAvatar(
                              radius: Sizes.s16.r,
                              backgroundColor: AppColor.white,
                              child: const Icon(Icons.clear,
                                  color: AppColor.black)),
                        )
                      ],
                    ),
                  ),
                ))
              ]),
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
                        appText(addedItem?.length.toString() ?? "-")
                      ],
                    ),
                    Column(
                      children: [
                        appText("Width", style: AppTextStyle.greySubTitle),
                        appText(addedItem?.width.toString() ?? "-")
                      ],
                    ),
                    Column(
                      children: [
                        appText("Height", style: AppTextStyle.greySubTitle),
                        appText(addedItem?.height.toString() ?? "-")
                      ],
                    ),
                    Column(
                      children: [
                        appText("Weight", style: AppTextStyle.greySubTitle),
                        appText(addedItem?.weight.toString() ?? "-")
                      ],
                    ),
                    Column(
                      children: [
                        appText("Quantity", style: AppTextStyle.greySubTitle),
                        appText(addedItem?.quantity.toString() ?? "-")
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
                    children: const [
                      // forwardAndBackWardButton(Icons.arrow_back_ios_outlined),
                      // forwardAndBackWardButton(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                )))
      ]);
    });
  }
}

class ScrollDiamensionField {
  int? index;
  ScrollDiamensionField({this.index});
}

class TextFieldData {
  String? hintText;
  String? controller;

  TextFieldData({this.controller, this.hintText});
}

class AddItem {
  String? itemImage;
  String? itemName;
  String? quantity;
  String? length;
  String? width;
  String? height;
  String? weight;

  AddItem(
      {this.itemImage,
      this.itemName,
      this.quantity,
      this.length,
      this.width,
      this.height,
      this.weight});
}
