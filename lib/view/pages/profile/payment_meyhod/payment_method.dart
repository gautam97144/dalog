import 'package:dalog_distribution/constant/app_text_style.dart';
import 'package:dalog_distribution/view/widgets/sized_box.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../../../../constant/constant.dart';
import '../../../../models/debit_card.dart';
import '../../../../utils/utils.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SecondaryAppBar(
          title: "Payment method",
        ),
        body: CustomScroll(
          children: [
            CustomSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              appText("Saved cards", style: AppTextStyle.headingTextTile),
              const Expanded(child: SizedBox()),
              plusButton(),
              SizedBoxW8(),
              InkWell(
                  onTap: () => CustomDialog.dialogShow(
                          title: appText("Add new Card",
                              style: AppTextStyle.headline2),
                          context,
                          children: [
                            dialogContent(),
                          ]),
                  child:
                      appText("Add new card", style: AppTextStyle.redTextStyle))
            ]),
            debitCardWidget(),
            appText("Paypal", style: AppTextStyle.headingTextTile),
            SizedBoxH14(),
            PrimaryTextField(
              hintText: "Enter Paypal ID",
            ),
            SizedBoxH28(),
            appText("Apple ID", style: AppTextStyle.headingTextTile),
            SizedBoxH14(),
            PrimaryTextField(
              hintText: "Enter Apple ID",
            ),
            PrimaryTextField(
              hintText: "Password",
            ),
            appText("Banking info", style: AppTextStyle.headingTextTile),
            SizedBoxH10(),
            appText("payment method one",
                softWrap: true,
                style: AppTextStyle.subTitle
                    .copyWith(color: AppColor.primaryColor)),
            SizedBoxH10(),
            PrimaryTextField(),
            PrimaryTextField(
              hintText: "Bank account number",
            ),
            PrimaryTextField(
              hintText: "Confirm bank account number",
            ),
            PrimaryTextField(
              hintText: "Bank routing number",
            ),
          ],
        ));
  }

  Widget dialogContent() {
    return SizedBox(
      width: ScreenUtil().screenWidth / 1.4,
      child: Column(
        children: [
          PrimaryTextField(
            hintText: "Card no.",
          ),
          Row(
            children: [
              Flexible(child: PrimaryTextField(hintText: "Exp.date")),
              SizedBoxW8(),
              Flexible(child: PrimaryTextField(hintText: "Security code"))
            ],
          ),
          PrimaryButton(lable: "Add Card", onPressed: () {})
        ],
      ),
    );
  }

  Widget debitCardWidget() {
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
                          leading: selectionIcon(context, index),
                          trailing:
                              debitCard.value[index].expiryDate.toString(),
                          subTitle: debitCard.value[index].cardNo.toString(),
                        ),
                      );
                    }),
                SizedBox(
                  width: Sizes.s10.w,
                )
              ]);
            }));
  }

  Widget selectionIcon(BuildContext context, int index) {
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

  void debitCardSelection(int index) {
    for (DebitCardData element in debitCard.value) {
      element.isSelected = false;
    }
    debitCard.value[index].isSelected = true;

    debitCard.notifyListeners();
  }

  Widget plusButton() {
    return CircleAvatar(
      radius: Sizes.s16.r,
      backgroundColor: AppColor.red,
      child: const Icon(
        Icons.add,
        color: AppColor.white,
      ),
    );
  }
}
