import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/shared_widgets/background_simple.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/shared_widgets/app_bar.dart';
import '../../../app/shared_widgets/custom_button.dart';
import '../../../app/shared_widgets/expantion_tile.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});
  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
        child: Scaffold(
          backgroundColor: AppColors.trans,
          resizeToAvoidBottomInset: false,
          appBar: AppBarCustom(title: 'Contact Us'.tr,trailing: true,),
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              2.h.height,
              Text(
                'Message'.tr,
                style: AppTextStyles.bodyTextBold,
              ),
              1.h.height,
              TextFormField(
                onChanged: (value) {

                },
                readOnly: false,
                controller:controller.messageCtrl ,
                keyboardType:TextInputType.text ,
                // validator:widget.validator ,
                cursorColor:AppColors.black ,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Write your message here...'.tr,
                  contentPadding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  fillColor:AppColors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color:AppColors.grey.withOpacity(0.10),width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  hintStyle:const TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppColors.hintColor),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color:AppColors.grey.withOpacity(0.10),width: 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              2.h.height,
              Text(
                'FAQ’s for knowledge'.tr,
                style: AppTextStyles.bodyTextBold,
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.faqs.length,
                  itemBuilder: (context, index) => CustomExpansionTile(
                      ctrl: controller.faqs[index]['ctrl'],
                      title:'${controller.faqs[index]['question']}'.tr,
                      children: [
                        Container(
                          margin:const EdgeInsets.only(top: 2),
                          padding:const EdgeInsets.all(18.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border(top: BorderSide(color: AppColors.white.withOpacity(0.50),width: 2))
                            // color: AppColors.primary
                          ),
                          child: Text('${controller.faqs[index]['answer']}'.tr,style: AppTextStyles.hintText.copyWith(overflow: TextOverflow.visible),),
                        ),
                      ]
                  ).paddingOnly(top: 2.h),
                ),
              ),
              2.h.height,
              CustomGradientButton(
                text: 'Submit'.tr,
                onPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        backgroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(Utils.getIconPath('check'),scale: 4.0,),
                              Text(
                                'Your email has been delivered'.tr,
                                style: AppTextStyles.twentySemiBoldText.copyWith(overflow: TextOverflow.visible),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );// Custom popup widget
                    },
                  );
                },
              ),
              2.h.height,
            ],
          ).paddingSymmetric(horizontal: 20),
        )
    );
  }
}
