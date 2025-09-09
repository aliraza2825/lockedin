import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_courier/app/config/app_text_styles.dart';
import 'package:medical_courier/data/models/delivery_step.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:medical_courier/app/config/global_var.dart';
import 'package:medical_courier/app/routes/app_pages.dart';
import 'package:medical_courier/app/utils/utils.dart';
import 'package:medical_courier/data/models/full_order.dart';
import 'package:medical_courier/data/models/order.dart';
import 'package:medical_courier/presentation/home/controllers/home_controller.dart';
import 'package:medical_courier/presentation/navigation_map/controllers/navigation_map_controller.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:signature/signature.dart';
import 'package:geolocator/geolocator.dart';
import 'package:medical_courier/app/shared_widgets/app_bar.dart';
import 'package:sizer/sizer.dart';

class NavigationMapView extends StatefulWidget {
  const NavigationMapView({Key? key}) : super(key: key);

  @override
  State<NavigationMapView> createState() => _NavigationMapViewState();
}

class _NavigationMapViewState extends State<NavigationMapView> {
  NavigationMapController controller = Get.find<NavigationMapController>();
  LatLng sourceLocation = LatLng(31.483999, 74.296078);
  LatLng destinationLocation = LatLng(31.469046, 74.297945);

  final Set<Marker> markers = {};
  Order? order;
  final Set<Polyline> polylines = {};
  final List<LatLng> polylineCoordinates = [];
  final Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription<Position>? positionStream;
  List<LatLng> fullRoutePoints = [];
  BitmapDescriptor? riderIcon;
  BitmapDescriptor? destinationIcon;

  @override
  void initState() {
    order = Get.arguments;
    if(order!.orderTechnicianLocation?.orderTrackingStatus != null && order!.orderTechnicianLocation!.orderTrackingStatus! > 1){
      destinationLocation = LatLng(order!.labLatitude!, order!.labLongitude!);
    }else{
      destinationLocation = LatLng(order!.pickupLatitude!, order!.pickupLongitude!);
    }
    sourceLocation = LatLng(Globals.latitude, Globals.longitude);
    super.initState();
    _loadIcons();
    _getPolyline();
    _trackUserLocation();
  }

  void _updateDestinationAndRoute() {
  if (controller.fullOrder?.orderTechnicianLocation?.orderTrackingStatus != null &&
      controller.fullOrder!.orderTechnicianLocation!.orderTrackingStatus! > 1) {
    destinationLocation = LatLng(controller.fullOrder!.labLatitude!, controller.fullOrder!.labLongitude!);
  } else {
    destinationLocation = LatLng(controller.order!.pickupLatitude!, controller.order!.pickupLongitude!);
  }

  // Clear old route and recreate
  polylineCoordinates.clear();
  polylines.clear();
  _getPolyline(); // Regenerate polyline
}

  Future<void> _loadIcons() async {
    riderIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48), devicePixelRatio: 2.5),
      Utils.getIconPath("delivery-bike"),
    );
    destinationIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(48, 48)),
      Utils.getIconPath("lab-marker"),
    );
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  void _trackUserLocation() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) async {
      final newLatLng = LatLng(position.latitude, position.longitude);

      if (fullRoutePoints.isNotEmpty) {
        fullRoutePoints.removeWhere((point) =>
            Geolocator.distanceBetween(
              point.latitude,
              point.longitude,
              newLatLng.latitude,
              newLatLng.longitude,
            ) < 30);

        polylines.removeWhere((p) => p.polylineId.value == "route");
        polylines.add(Polyline(
          polylineId: const PolylineId("route"),
          points: [newLatLng, ...fullRoutePoints],
          color: Colors.blue,
          width: 5,
        ));
      }

      setState(() {
        markers.removeWhere((m) => m.markerId.value == "rider");

        markers.addAll({
          Marker(
            markerId: const MarkerId("rider"),
            position: newLatLng,
            icon: riderIcon ?? BitmapDescriptor.defaultMarker,
          ),
          Marker(
            markerId: const MarkerId("dest"),
            position: destinationLocation,
            icon: destinationIcon ?? BitmapDescriptor.defaultMarker,
          ),
        });
      });

      final controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLng(newLatLng));
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationMapController>(
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          appBar: AppBarCustom(title: "Navigation Map".tr),
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: sourceLocation,
                  zoom: 14,
                ),
                myLocationEnabled: true,
                markers: markers,
                polylines: polylines,
                onMapCreated: (controller) => _mapController.complete(controller),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0, // adjusted to make room for the button bar
                top: 0,
                child: DraggableScrollableSheet(
                  initialChildSize: 0.15,
                  minChildSize: 0.15,
                  maxChildSize: 0.8,
                  builder: (context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Center(
                              child: Container(
                                width: 40,
                                height: 4,
                                margin: const EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            controller.alreadystartedOrder == 0 || controller.alreadystartedOrder == controller.order.orderId ? SlideAction(
                              text: _getButtonText(controller.fullOrder!),
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              outerColor: controller.fullOrder?.orderTechnicianLocation?.orderTrackingStatus == 4 ? Colors.green : Colors.blue,
                              innerColor: Colors.white,
                              elevation: 4,
                              height: 60,
                              borderRadius: 12,
                              onSubmit: () => _handleSlideAction(controller.fullOrder!, controller),
                            ) : const SizedBox(),
                            Text('Distance', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red)),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.my_location, color: Colors.blue),
                                const Expanded(child: Divider(thickness: 1, color: Colors.grey)),
                                const Icon(Icons.location_on, color: Colors.red),
                                const SizedBox(width: 8),
                                Text(
                                  controller.order?.distanceInKm != null
                                      ? "${controller.order!.distanceInKm!.toStringAsFixed(2)} km"
                                      : "Unknown",
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text('Pickup Info', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red)),
                            const SizedBox(height: 6),
                            _buildRow("Pickup Date/Time", "${controller.fullOrder?.dateRequested ?? ''} ${controller.fullOrder?.timeRequested ?? ''}"),
                            _buildRow("Street", controller.fullOrder?.specimenPickupAddress ?? "N/A"),
                            _buildRow("City", controller.fullOrder?.specimenPickupCity ?? "N/A"),
                            _buildRow("State", controller.fullOrder?.specimenPickupState ?? "N/A"),
                            _buildRow("Zip", controller.fullOrder?.specimenPickupZip ?? "N/A"),
                            const SizedBox(height: 12),
                            Text('Patient Info', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.red)),
                            const SizedBox(height: 6),
                            _buildRow("Patient Name", "${controller.fullOrder?.firstName ?? ''} ${controller.fullOrder?.lastName ?? ''}"),
                            _buildRow("DOB", controller.fullOrder?.dateOfBirth ?? "N/A"),
                            _buildRow("Phone", controller.fullOrder?.cellNumber ?? "N/A"),
                            _buildRow("Home Phone", controller.fullOrder?.homeNumber ?? "N/A"),
                            
                            buildSectionCard('Delivery Info', [
                              _buildRow('Deliver To', controller.fullOrder?.labAddress ?? '-'),
                              _buildRow('Pickup From', controller.fullOrder?.specimenPickupAddress ?? '-'),
                            ]),
                            // Test Details
                            buildSectionCard('Test Details',
                              controller.fullOrder!.orderTestRequests != null && controller.fullOrder!.orderTestRequests!.isNotEmpty
                                  ? controller.fullOrder!.orderTestRequests!
                                      .map((test) => Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              _buildRow('Test Name', test.testRequestedName ?? '-'),
                                              _buildRow('Fasting', (test.isFasting ?? false) ? 'Yes' : 'No'),
                                              Divider(height: 2.h, color: Colors.grey.shade300),
                                            ],
                                          ))
                                      .toList()
                              : [
                                  _buildRow('No Tests Found', '-'),
                                ]
                            ),
                            const SizedBox(height: 80), // bottom padding for button
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 4, child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10.sp))),
          Expanded(flex: 6, child: Text(value, style: TextStyle(fontSize: 10.sp))),
        ],
      ),
    );
  }
  
  String _getButtonText(FullOrder order) {
    switch (order.orderTechnicianLocation?.orderTrackingStatus) {
      case null:
        return "Start Pickup";
      case 1:
        return "Arrived at Patient Location";
      case 2:
        return "Start Delivery to Lab";
      case 3:
        return "Arrived at Lab";
      default:
        return "Mark Completed";
    }
  }

  Future<void> _handleSlideAction(FullOrder order, NavigationMapController controller) async {
  if (order.orderTechnicianLocation?.orderTrackingStatus == null) {
    controller.updateLocation(order);
  }else{
    final status = order.orderTechnicianLocation!.orderTrackingStatus;

    if (status == 3) {
      await _showSignaturePad(
        title: "Proof of Sample Delivered",
        onSubmit: (signature) async {
          await controller.updateLocation(order,signature: signature);
        },
      );
    } else if (status == 4) {
      await _showImageCapturePopup((image1,image2) async {
        bool success = await controller.updateLocation(order,image1: image1,image2: image2);
        if (success) {
          _showDeliveryCompleteDialog();
        }
      },controller.image1,controller.image2);
    } else {
      await controller.updateLocation(order);
    }
    _updateDestinationAndRoute(); 
  }
}

  void _getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();

    final request = PolylineRequest(
      origin: PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      destination: PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
      mode: TravelMode.driving,
    );

    try {
      final result = await polylinePoints.getRouteBetweenCoordinates(
        request: request,
        googleApiKey: "AIzaSyAtABuYQtp8Yco-fJT_oRE4KOdnA-h80sA",
      );

      if (result.points.isEmpty) {
        print("\u274C ZERO_RESULTS - No route found between the given coordinates.");
        return;
      }

      fullRoutePoints = result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
      polylines.add(Polyline(
        polylineId: const PolylineId("route"),
        points: fullRoutePoints,
        width: 5,
        color: Colors.blue,
      ));
      setState(() {});
    } catch (e) {
      log("\u274C Error getting polyline: $e");
    }
  }

  Future<void> _showSignaturePad({
    required String title,
    required Function onSubmit,
  }) async {
    final SignatureController _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Signature(
                  controller: _signatureController,
                  height: 250,
                  backgroundColor: Colors.grey[200]!,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _signatureController.clear();
                      },
                      child: const Text("Clear"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_signatureController.isNotEmpty) {
                          final signature = await _signatureController.toPngBytes();
                          Navigator.of(context).pop();
                          onSubmit(signature);
                        }
                      },
                      child: const Text("Submit"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showDeliveryCompleteDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 80,
                ),
                const SizedBox(height: 16),
                const Text(
                  "\ud83c\udf89 Congratulations!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "The sample has been successfully delivered to the lab.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.back();
                    Get.find<HomeController>().getPendingOrders();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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

  Future<void> _showImageCapturePopup(Function onSubmit,XFile? image1,XFile? image2) async {
  final picker = ImagePicker();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickImage(int imageNumber) async {
            final source = await showModalBottomSheet<ImageSource>(
              context: context,
              builder: (_) => SafeArea(
                child: Wrap(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.camera_alt),
                      title: const Text('Camera'),
                      onTap: () => Navigator.of(context).pop(ImageSource.camera),
                    ),
                    ListTile(
                      leading: const Icon(Icons.image),
                      title: const Text('Gallery'),
                      onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                    ),
                  ],
                ),
              ),
            );

            if (source != null) {
              final picked = await picker.pickImage(source: source);
              if (picked != null) {
                setState(() {
                  if (imageNumber == 1) {
                    image1 = picked;
                  } else {
                    image2 = picked;
                  }
                });
              }
            }
          }

          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 420,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Proof of Delivery Images", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(1),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: image1 != null
                                ? Image.file(File(image1!.path), fit: BoxFit.cover)
                                : const Icon(Icons.add_a_photo, size: 36),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => pickImage(2),
                          child: Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: image2 != null
                                ? Image.file(File(image2!.path), fit: BoxFit.cover)
                                : const Icon(Icons.add_a_photo, size: 36),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if (image1 != null && image2 != null) {
                        Navigator.of(context).pop();
                        onSubmit(image1,image2!);
                      } else {
                        Utils.showToast(message: "Please upload Proof of Delivery images");
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
}