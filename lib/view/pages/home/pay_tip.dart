import 'package:dalog_distribution/constant/constant.dart';
import 'package:dalog_distribution/view/widgets/widget.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_text_style.dart';
import '../../../models/debit_card.dart';
import '../../../utils/utils.dart';
import '../../widgets/sized_box.dart';

class PayTip extends StatelessWidget {
  const PayTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SecondaryAppBar(
        title: "Pay Tips",
      ),
      bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: PrimaryPadding(
              verticalPadding: Sizes.s10.h,
              child: PrimaryButton(lable: "Pay \$5 Tips", onPressed: () {}))),
      body: CustomScroll(
        children: [
          CustomSizedBox(),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              appText(
                "Credit/Debit",
                style: AppTextStyle.headingTextTile,
              ),
              const Expanded(child: SizedBox()),
              SmallRedCircularIcon(
                raduis: Sizes.s14.r,
              ),
              SizedBoxW8(),
              appText("Saved Card",
                  style: AppTextStyle.greySubTitle
                      .copyWith(fontWeight: FontWeight.w700))
            ],
          ),
          SizedBoxH10(),
          const PrimaryTextField(
            hintText: "Card number",
          ),
          Row(
            children: [
              const Flexible(child: PrimaryTextField(hintText: "Exp. date")),
              SizedBoxW8(),
              const Flexible(child: PrimaryTextField(hintText: "Security Code"))
            ],
          ),
          appText(
            "Saved cards",
            style: AppTextStyle.headingTextTile,
          ),

          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: debitCard.value.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ValueListenableBuilder(
                      builder: (BuildContext context, value, Widget? child) {
                        return Padding(
                          padding: EdgeInsets.all(Sizes.s10.h),
                          child: InkWell(
                            onTap: () {
                              DebitCardBox.debitCardSelection(index);
                            },
                            child: DebitCardBox(
                              subTitle:
                                  debitCard.value[index].cardNo.toString(),
                              leading: selectionIcon(index, context),
                              title: debitCard.value[index].name.toString(),
                              trailing:
                                  debitCard.value[index].expiryDate.toString(),
                            ),
                          ),
                        );
                      },
                      valueListenable: debitCard,
                    ),
                  ],
                );
              }),

          // DebitCardBox(
          //   subTitle: '',
          //   leading: selectionIcon(context),
          //   title: '',
          //   trailing: '',
          // )
        ],
      ),
    );
  }

  Widget selectionIcon(int index, BuildContext context) {
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
}
