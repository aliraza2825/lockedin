import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_courier/app/routes/app_pages.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:medical_courier/app/shared_widgets/background_simple.dart';
import 'package:medical_courier/presentation/LogoLoadingScreen.dart';
import 'package:sizer/sizer.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/config/app_text_styles.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundSimpleWidget(
      child: GetBuilder<OrderDetailsController>(
        init: OrderDetailsController(),
        builder: (controller) {
          final order = controller.fullOrder;
          return LoadingOverlay(
            isLoading: controller.isLoading,
            child: Scaffold(
              backgroundColor: AppColors.trans,
              appBar: AppBarCustom(
                title: 'Order Details'.tr,
                trailing: null,
              ),
              body: SingleChildScrollView(
                padding: EdgeInsets.all(3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Alert', style: AppTextStyles.semiBold.copyWith(color: Colors.red)),
                          SizedBox(height: 0.5.h),
                          Text('Section or Fields will change according to the requirements.',
                              style: AppTextStyles.normalText.copyWith(color: Colors.black87),
                              softWrap: true,
                              overflow: TextOverflow.visible),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h),

                    buildSectionCard('Order Summary', [
                      buildRow('Order No', order.orderNo ?? '-'),
                      buildRow('Status', order.orderStatusName ?? '-'),
                    ]),

                    buildSectionCard('Delivery Info', [
                      buildRow('Deliver To', order.labAddress ?? '-'),
                      buildRow('Pickup From', order.specimenPickupAddress ?? '-'),
                    ]),

                    buildSectionCard('Patient Details', [
                      buildRow('Name', '${order.firstName ?? ''} ${order.lastName ?? ''}'),
                      buildRow('MRN', order.mrNnumber ?? '-'),
                      buildRow('DOB', order.dateOfBirth ?? '-'),
                      buildRow('Phone (Cell)', order.cellNumber ?? '-'),
                      buildRow('Phone (Home)', order.homeNumber ?? '-'),
                      buildRow('Special Instructions', order.patientSpecialInstructions ?? '-'),
                      buildRow('Quality of Care Notes', order.orderNotes ?? '-'),
                    ]),

                    // Test Details
                    buildSectionCard('Test Details',
                        controller.fullOrder.orderTestRequests != null &&
                                controller.fullOrder.orderTestRequests!.isNotEmpty
                            ? controller.fullOrder.orderTestRequests!
                                .map((test) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        buildRow('Test Name', test.testRequestedName ?? '-'),
                                        buildRow('Fasting', (test.isFasting ?? false) ? 'Yes' : 'No'),
                                        Divider(height: 2.h, color: Colors.grey.shade300),
                                      ],
                                    ))
                                .toList()
                            : [
                                buildRow('No Tests Found', '-'),
                    ]),

                    buildSectionCard('Order Details', [
                      buildRow('Date Requested', order.dateRequested ?? '-'),
                      buildRow('Time Requested', order.timeRequested ?? '-'),
                      buildRow('Home Visit', (order.isHomeVisit ?? false) ? 'Yes' : 'No'),
                      buildRow('Emergency', (order.isEmergency ?? false) ? 'Yes' : 'No'),
                      buildRow('Specimen Pickup Street', order.specimenPickupAddress ?? '-'),
                      buildRow('City', order.specimenPickupCity ?? '-'),
                      buildRow('State', order.specimenPickupState ?? '-'),
                      buildRow('Zip', order.specimenPickupZip ?? '-'),
                      buildRow('Order Facility Dept.', order.orderingFacilityDepartmentName ?? '-'),
                      buildRow('Order Facility Phone', order.orderingFacilityPhoneNo ?? '-'),
                      buildRow('Requester Email', order.requesterEmail ?? '-'),
                      buildRow('Requester First Name', order.requesterFirstName ?? '-'),
                      buildRow('Requester Last Name', order.requesterLastName ?? '-'),
                      buildRow('Tests Requested',
                          order.orderTestRequests?.map((e) => e.testRequestedName).join(', ') ?? '-'),
                      buildRow('Order Type', order.orderTypeName ?? '-'),
                      buildRow('Ordering Facility', order.orderingFacilityNames ?? '-'),
                      buildRow('General Ledger Code', order.orderingFacilityGeneralLedgerCodes ?? '-'),
                      buildRow('Physician Name',
                          '${order.orderingPhysicianFirstName ?? ''} ${order.orderingPhysicianLastName ?? ''}'),
                      buildRow('Physician Title', order.orderingPhysicianTitle ?? '-'),
                      buildRow('Order Notes', order.orderNotes ?? '-'),
                      buildRow('Confirm General Ledger Code', order.confirmGeneralLedgerCode ?? '-'),
                      buildRow('National User Identification', order.nationalUserIdentification ?? '-'),
                    ]),

                    buildSectionCard('Delivery Details', [
                      buildRow('Technician Name', order.technicianName ?? '-'),
                      buildRow('Requested Delivery Time', order.timeRequested ?? '-'),
                      buildRow('Order Placement Time', order.placementTime ?? '-'),
                      buildRow('Order Accept Time', order.startTime ?? '-'),
                      buildRow('Order Pickup Time', order.pickupTime ?? '-'),
                      buildRow('Order Delivery Time', order.deliveryTime ?? '-'),
                      buildRow('Order Completion Time', order.completionTime ?? '-'),
                      buildRow('Delivery Instructions', order.orderNotes ?? '-'),
                    ]),

                    buildSectionCard('Proof Of Delivery', [
                      Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: controller.fullOrder?.imageSignatureUrl != null ? Image.network("https://blood-tracker-apis.rootpointers.net/${controller.fullOrder!.imageSignatureUrl}",fit: BoxFit.cover) : Center(
                          child: Icon(Icons.image, size: 50, color: Colors.grey),
                        ),
                      ),
                    ]),
                    // Test Details
                    buildSectionCard('Proof of Delivery Images',
                        controller.fullOrder.orderDeliveredMedia != null &&
                                controller.fullOrder.orderDeliveredMedia!.isNotEmpty
                            ? controller.fullOrder.orderDeliveredMedia!
                                .map((test) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network("https://blood-tracker-apis.rootpointers.net/${test.imageUrl}",fit: BoxFit.cover),
                                        Divider(height: 2.h, color: Colors.grey.shade300),
                                      ],
                                    ))
                                .toList()
                            : [
                                SizedBox(height: 2.h),
                    ]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.semiBold.copyWith(color: Colors.red, fontSize: 13.sp)),
          SizedBox(height: 1.h),
          ...children,
        ],
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(label,
                style: AppTextStyles.normalText.copyWith(fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: AppTextStyles.normalText.copyWith(color: Colors.black87),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}