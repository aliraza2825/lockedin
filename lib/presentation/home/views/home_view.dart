import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/config/app_colors.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/app/extensions/extensions.dart';
import 'package:medical_courier/app/routes/app_pages.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:sizer/sizer.dart';
import '../controllers/home_controller.dart';
import '../../../data/models/order.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: AppColors.trans,
              body: Column(
                children: [
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        _buildWelcomeSection(),
                        SizedBox(height: 2.h),
                        _buildFeaturedBanner(controller),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black87,
                      labelStyle: AppTextStyles.bodyTextBold.copyWith(fontSize: 10.sp),
                      unselectedLabelStyle: AppTextStyles.bodyText400.copyWith(fontSize: 10.sp),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(child: Text("New Orders")),
                        Tab(child: Text("Pending Orders")),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildOrdersList(context, controller.orders, controller,false),
                        _buildOrdersList(context, controller.pendingOrders, controller,true),
                      ],
                    ),
                  ),
                  /// Sticky bottom banner
                  controller.alreadystartedOrder > 0 && controller.ongoingOrder.orderId != null ? Positioned(
                    left: 0,
                    right: 0,
                    bottom: 56, // Height of BottomNavigationBar
                    child: _buildStickyBanner(),
                  ) : const SizedBox(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStickyBanner() {
  return GestureDetector(
          onTap: () {
            Get.toNamed(Routes.NAVIGATION_MAP, arguments: controller.ongoingOrder);
          },
          child:
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.pink[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.timer, color: Colors.pink),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text("${controller.ongoingOrder.firstName} ${controller.ongoingOrder.lastName}", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
                      Text(controller.ongoingOrder.orderStatusName.toString(), style: TextStyle(color: Colors.pink)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:  Text(
                    controller.ongoingOrder.timeRequested.toString(),
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: const Icon(Icons.forward, color: Colors.pink),
                ),
              ],
            ),
          )
        );
}

  /// ✅ Welcome Section
  Widget _buildWelcomeSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Rider Pal 👋'.tr,
                style: AppTextStyles.semiBold.copyWith(
                  color: AppColors.darkPrimary,
                  fontSize: 15.sp,
                ),
              ),
              Text(
                'Manage Your Orders'.tr,
                style: AppTextStyles.semiBold.copyWith(
                  color: AppColors.darkPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// ✅ Banner
  Widget _buildFeaturedBanner(HomeController controller) {
    return Container(
      width: Get.width - 40,
      height: Get.height / 5.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.secondaryGradient,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(Utils.getImagePath('Banner')),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Manage your orders'.tr,
                    style: AppTextStyles.semiBold.copyWith(
                      fontSize: 13.sp,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    'Turn your Status ON/OFF'.tr,
                    style: AppTextStyles.small.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                  2.h.height,
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 1,
                          offset: const Offset(3, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                      onPressed: () => controller.changeStatus(),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(160, 40),
                        backgroundColor: controller.userStatus == 1
                            ? AppColors.red
                            : AppColors.primary,
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Text(controller.userStatus == 1 ? "Offline" : "Online"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrdersList(BuildContext context, List<Order> orders, HomeController controller, bool isPending) {
  return RefreshIndicator(
    onRefresh: () async {
      if(isPending){
        await controller.getPendingOrders();
      }else{
        await controller.getNewOrders();
      }
    },
    child: orders.isEmpty
        ? ListView( // Required to allow pull when list is empty
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [
              SizedBox(height: 200, child: Center(child: Text("No orders found"))),
            ],
          )
        : ListView.builder(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderBox(context, order, index, isPending);
            },
          ),
  );
}

  /// ✅ Order Card
  Widget _buildOrderBox(BuildContext context, Order order, int index,bool isPending) {
    return GestureDetector(
      onTap: () => isPending ? (order.orderStatus != 3 ? Get.toNamed(Routes.NAVIGATION_MAP, arguments: order) : Get.toNamed(Routes.ORDER_DETAILS, arguments: order)) : _showOrderDetailsDialog(context, order, index) ,
      child: Container(
        width: Get.width - 40,
        margin: EdgeInsets.only(top: 1.h, bottom: 2.h),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
            const SizedBox(height: 8),
            Text(
              "Address: ${order.address ?? 'N/A'}",
              style: AppTextStyles.bodyText400.copyWith(fontSize: 10.sp),
            ),
            const SizedBox(height: 8),
            Text(
              order.distanceInKm != null
                  ? "Distance: ${order.distanceInKm!.toStringAsFixed(2)} km"
                  : "Distance: Unknown",
              style: AppTextStyles.bodyText400.copyWith(fontSize: 10.sp),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Order Details Popup
  void _showOrderDetailsDialog(BuildContext context, Order order, int index) {
    final controller = Get.find<HomeController>();

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.all(16),
          constraints: BoxConstraints(maxHeight: 85.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Text('Distance', style: AppTextStyles.semiBold.copyWith(fontSize: 13.sp, color: Colors.red)),
                SizedBox(height: 1.h),
                Row(
                  children: [
                    const Icon(Icons.my_location, color: Colors.blue),
                    const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 8),
                    Text(
                      order.distanceInKm != null
                          ? "${order.distanceInKm!.toStringAsFixed(2)} km"
                          : "Unknown",
                      style: AppTextStyles.bodyText400.copyWith(color: Colors.black),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text('Pickup Info', style: AppTextStyles.semiBold.copyWith(fontSize: 13.sp, color: Colors.red)),
                SizedBox(height: 1.h),
                _buildRow("Pickup Date/Time", "${order.dateRequested ?? ''} ${order.timeRequested ?? ''}"),
                _buildRow("Street", order.specimenPickupAddress ?? "N/A"),
                _buildRow("City", order.specimenPickupCity ?? "N/A"),
                _buildRow("State", order.specimenPickupState ?? "N/A"),
                _buildRow("Zip", order.specimenPickupZip ?? "N/A"),
                SizedBox(height: 2.h),
                Text('Patient Info', style: AppTextStyles.semiBold.copyWith(fontSize: 13.sp, color: Colors.red)),
                SizedBox(height: 1.h),
                _buildRow("Patient Name", "${order.firstName ?? ''} ${order.lastName ?? ''}"),
                _buildRow("DOB", order.dateOfBirth ?? "N/A"),
                _buildRow("Phone", order.cellNumber ?? "N/A"),
                _buildRow("Home Phone", order.homeNumber ?? "N/A"),
                SizedBox(height: 2.h),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          controller.changeOrderStatus(2, order.orderId!, index);
                          Get.back();
                        },
                        child: Text("Accept", style: AppTextStyles.semiBold.copyWith(color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Reject", style: AppTextStyles.semiBold.copyWith(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.normalText.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.normalText.copyWith(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}