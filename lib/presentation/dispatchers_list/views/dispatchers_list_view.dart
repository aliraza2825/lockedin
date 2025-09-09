import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:medical_courier/app/shared_widgets/background_simple.dart';
import 'package:medical_courier/data/models/chip.dart';
import 'package:medical_courier/data/models/dispatcher.dart';
import 'package:medical_courier/data/provider/network/api_endpoint.dart';
import 'package:sizer/sizer.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/routes/app_pages.dart';
import '../../../app/utils/utils.dart';
import '../controllers/dispatchers_list_controller.dart';
import '../../chat/controllers/chat_controller.dart';

class DispatchersListView extends GetView<DispatchersListController> {
  const DispatchersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
      child: GetBuilder<DispatchersListController>(
        init: DispatchersListController(),
        builder: (c) {
          return Scaffold(
            backgroundColor: AppColors.trans,
            appBar: AppBarCustom(title: 'Dispatchers List'.tr, trailing: null),
            body:
                controller.isLoading
                    ? const Center(
                      child: CupertinoActivityIndicator(
                        radius: 15,
                        color: AppColors.primary,
                      ),
                    )
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        2.h.height,
                        Expanded(
                          child: ListView.separated(
                            itemCount: controller.dispatchers.length,
                            separatorBuilder:
                                (_, __) => SizedBox(height: 1.5.h),
                            itemBuilder: (context, index) {
                              final dispatcher = controller.dispatchers[index];

                              final fullName =
                                  "${dispatcher.firstName ?? ''} ${dispatcher.lastName ?? ''}"
                                      .trim();
                              final location =
                                  "${dispatcher.city ?? ''}, ${dispatcher.state ?? ''}"
                                      .replaceAll(RegExp(r'^, |, $'), '');

                              return Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.h,
                                    horizontal: 4.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fullName.isNotEmpty
                                            ? fullName
                                            : 'Unnamed Dispatcher',
                                        style: AppTextStyles.mediumHeading
                                            .copyWith(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                      0.5.h.height,
                                      if (dispatcher.email != null)
                                        Text(
                                          dispatcher.email!,
                                          style: AppTextStyles.bodyText
                                              .copyWith(
                                                fontSize: 10.sp,
                                                color: Colors.grey[700],
                                              ),
                                        ),
                                      if (dispatcher.phone != null)
                                        Text(
                                          dispatcher.phone!,
                                          style: AppTextStyles.bodyText
                                              .copyWith(
                                                fontSize: 10.sp,
                                                color: Colors.grey[700],
                                              ),
                                        ),
                                      if (location.trim().isNotEmpty)
                                        Text(
                                          location,
                                          style: AppTextStyles.bodyText
                                              .copyWith(
                                                fontSize: 10.sp,
                                                color: Colors.grey[600],
                                              ),
                                        ),
                                      1.h.height,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Chip(
                                            label: Text(
                                              dispatcher.isActive == true
                                                  ? "Active"
                                                  : "Inactive",
                                              style: TextStyle(
                                                color:
                                                    dispatcher.isActive == true
                                                        ? Colors.green
                                                        : Colors.red,
                                              ),
                                            ),
                                            backgroundColor:
                                                dispatcher.isActive == true
                                                    ? Colors.green[50]
                                                    : Colors.red[50],
                                          ),
                                          Chip(
                                            label: Text(
                                              dispatcher.isAccountApproved ==
                                                      true
                                                  ? "Approved"
                                                  : "Not Approved",
                                              style: TextStyle(
                                                color:
                                                    dispatcher.isAccountApproved ==
                                                            true
                                                        ? Colors.blue
                                                        : Colors.orange,
                                              ),
                                            ),
                                            backgroundColor:
                                                dispatcher.isAccountApproved ==
                                                        true
                                                    ? Colors.blue[50]
                                                    : Colors.orange[50],
                                          ),
                                        ],
                                      ),
                                      2.h.height,
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            _startChatWithDispatcher(
                                              dispatcher,
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.chat_bubble_outline,
                                          ),
                                          label: const Text("Start Chat"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primary,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                              vertical: 1.4.h,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            textStyle: AppTextStyles.bodyText
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ).paddingSymmetric(horizontal: 5.w),
          );
        },
      ),
    );
  }

  /// Start chat with dispatcher
  void _startChatWithDispatcher(Dispatcher dispatcher) async {
    try {
      // Get chat controller
      final chatController = Get.find<ChatController>();

      // Create dispatcher chat (this will handle navigation)
      await chatController.createDispatcherChat(dispatcher.userId.toString());
    } catch (e) {
      print('Error starting chat with dispatcher: $e');
      Utils.showToast(message: 'Failed to start chat');
    }
  }
  
}
