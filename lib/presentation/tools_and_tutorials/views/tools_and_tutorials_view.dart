import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locked_in/app/extensions/extensions.dart';
import 'package:locked_in/data/models/order.dart';
import 'package:sizer/sizer.dart';
import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../../../app/routes/app_pages.dart';
import '../controllers/tools_and_tutorials_controller.dart';

class ToolsAndTutorialsView extends GetView<ToolsAndTutorialsController> {
  const ToolsAndTutorialsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: GetBuilder<ToolsAndTutorialsController>(
            init: ToolsAndTutorialsController(),
            builder: (c) {
              return Scaffold(
                backgroundColor: AppColors.trans,
                appBar: AppBar(
                  title: Center(
                      child : Text(
                        'My Completed Orders'.tr,
                        style: AppTextStyles.heading,
                      )
                  ),
                  automaticallyImplyLeading: false
                ),
                body:Column(
                  children: [
                    Expanded(
      child: _buildOrdersList(context, controller.orders, controller),
    ),
                    2.h.height,
                  ],
                ).paddingSymmetric(horizontal: 5.w),
              );
            })
    );
  }

  /// ✅ Order List
  Widget _buildOrdersList(BuildContext context, List<Order> orders, ToolsAndTutorialsController controller) {
    return orders.isEmpty
        ? const Center(child: Text("No orders found"))
        : ListView.builder(
            controller: controller.scrollController,
            padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderBox(context, order);
            },
          );
  }
Widget _buildOrderBox(BuildContext context, Order order) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ORDER_DETAILS, arguments: order),
      child: Container(
        width: Get.width - 10,
        margin: EdgeInsets.only(top: 1.h, bottom: 1.h),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient: ${order.firstName ?? ''} ${order.lastName ?? ''}",
              style: AppTextStyles.primaryClrHeading,
            ),
            const SizedBox(height: 4),
            Text(
              "Address: ${order.address ?? 'N/A'}",
              style: AppTextStyles.bodyText400.copyWith(fontSize: 10.sp),
            ),
            const SizedBox(height: 4),
            Text(
              order.distanceInKm != null
                  ? "Lab: ${order.labName}"
                  : "Lab: Unknown",
              style: AppTextStyles.bodyText400.copyWith(fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }
}
