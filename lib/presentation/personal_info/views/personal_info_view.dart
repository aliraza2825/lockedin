import 'package:locked_in/app/extensions/extensions.dart';
import 'package:locked_in/app/shared_widgets/text_field.dart';
import 'package:locked_in/app/shared_widgets/background.dart';
import 'package:locked_in/app/shared_widgets/custom_button.dart';
import 'package:locked_in/app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../controllers/personal_info_controller.dart';

class PersonalInfoView extends GetView<PersonalInfoController> {
  const PersonalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalInfoController>(
      init: PersonalInfoController(),
      builder: (context) {
        return BackgroundWidget(
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            child: WillPopScope(
              onWillPop: () async => false,
              child: Scaffold(
                // resizeToAvoidBottomInset: false,
                backgroundColor: AppColors.trans,
                body: SingleChildScrollView(
                  child: Form(
                    key:controller.formKey,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        8.h.height,
                        LinearProgressIndicator(
                            value: 1.0, // 60% progress
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary)
                        ),
                        4.h.height,
                        Center(
                          child:Text(
                            'Personal Information'.tr,
                            style: AppTextStyles.heading.copyWith(color: AppColors.primary),
                          )
                        ),
                        4.h.height,
                        Center(
                          child: Stack(
                            children: [
                              controller.avatarImage==null ?
                              Container(
                                height: 100,
                                width: 100,
                                decoration:const BoxDecoration(
                                    color: AppColors.grey200, shape: BoxShape.circle),
                                child:  Icon(
                                  CupertinoIcons.person_alt_circle,
                                  color: AppColors.hintColor.withOpacity(0.30),
                                  size: 50,
                                ),
                              ):
                              Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey,shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: FileImage(controller.avatarImage!),
                                          fit: BoxFit.cover))
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: ()async{
                                     await _showImageSourceActionSheet(Get.context!, controller);
                                    },
                                    child:const CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppColors.grey400,
                                      child: Icon(
                                        Icons.edit,
                                        size: 12,
                                        color: AppColors.white,
                                      ),
                                    ),  
                                  ))
                            ],
                          ),
                        ),
                        3.5.h.height,
                         Text(
                          'Full Name'.tr,
                          style: AppTextStyles.bodyTextBold,
                        ),
                        InputTextField(
                            hint: 'Enter Full Name'.tr,
                            ctrl: controller.nameCtrl,
                            length: 30,
                            keyboardType: TextInputType.name,
                            validator:(value) {
                              if(value!.isEmpty){
                                return 'Enter full name'.tr;
                              }else {
                                return null;
                              }
                            },
                            readOnly: false),
                        2.h.height,
                         Text(
                          'Address'.tr,
                          style: AppTextStyles.bodyTextBold,
                        ),
                        InputTextField(
                            hint: 'Enter Your Address'.tr,
                            ctrl: controller.emailCtrl,
                            keyboardType: TextInputType.text,
                            length: 50,
                            // errorText:!GetUtils.isEmail(controller.emailCtrl.text)? 'Invalid email':null,
                            validator:(value) {
                              if(value!.isEmpty){
                                return 'Enter Address'.tr;
                              }
                            },
                            readOnly: false),
                        2.h.height,
                         Text(
                          'Age'.tr,
                          style: AppTextStyles.bodyTextBold,
                        ),
                        InputTextField(
                            hint: 'Enter Your Age'.tr,
                            ctrl: controller.ageCtrl,
                            keyboardType: TextInputType.number,
                            length: 3,
                            validator:(value) {
                              if(value!.isEmpty){
                                return 'Enter age'.tr;
                              }else {
                                return null;
                              }
                            },
                            readOnly: false),
                        2.h.height,
                        
                        // ---------- NEW: Gender ----------
                        Text(
                          'Gender'.tr,
                          style: AppTextStyles.bodyTextBold,
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 8,
                          children: ['Male', 'Female'].map((g) {
                            final bool isSel = controller.selectedGender == g;
                            return ChoiceChip(
                              label: Text(
                                g.tr,
                                style: AppTextStyles.bodyText.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: isSel ? AppColors.primary : AppColors.black,
                                ),
                              ),
                              selected: isSel,
                              onSelected: (_) => controller.setGender(g),
                              selectedColor: AppColors.primary.withOpacity(0.12),
                              backgroundColor: AppColors.white,
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: isSel ? AppColors.primary : Colors.grey.shade300,
                                ),
                              ),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            );
                          }).toList(),
                        ),
                        controller.stateCtrl.text.isNotEmpty?6.h.height :8.h.height,
                        CustomGradientButton(
                          text: 'Save'.tr,
                          onPress: () {
                            if(controller.formKey.currentState!.validate() && controller.avatarImage!=null){
                              controller.personalInfo();
                            }else{
                              if(controller.avatarImage == null){
                              Utils.showToast(message: "Profile Picture is required!".tr);
                              }
                            }
                          },
                        ),
                        4.h.height,
                      ],
                    ).paddingSymmetric(horizontal: 20),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
  Future<void> _showImageSourceActionSheet(BuildContext context, PersonalInfoController controller) async {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              1.h.height,
              ListTile(
                leading: Image.asset(Utils.getIconPath('camera'),width: 20,height: 20,),
                title: Text('Camera'.tr,style: AppTextStyles.normalText,),
                onTap: () async {
                  Get.back();
                controller.getCameraImage();
                },
              ),
              ListTile(
                leading: Image.asset(Utils.getIconPath('gallery'),width: 20,height: 20,),
                title: Text('Gallery'.tr,style: AppTextStyles.normalText,),
                onTap: () async {
                  controller.getGalleryImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
