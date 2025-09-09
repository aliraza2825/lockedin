class FullOrder {
  int? patientId;
  String? firstName;
  String? lastName;
  String? mrNnumber;
  String? dateOfBirth;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? cellNumber;
  String? homeNumber;
  String? patientSpecialInstructions;
  int? orderId;
  String? orderNo;
  int? serviceType;
  String? serviceTypeName;
  double? quantityRequested;
  String? dateRequested;
  String? timeRequested;
  bool? isHomeVisit;
  bool? isEmergency;
  bool? isPickupLocationSame;
  String? specimenPickupAddress;
  String? specimenPickupCity;
  String? specimenPickupState;
  String? specimenPickupZip;
  String? orderingFacilityDepartmentName;
  String? orderingFacilityPhoneNo;
  int? orderType;
  String? orderTypeName;
  int? orderingFacilityName;
  String? orderingFacilityNames;
  int? orderingFacilityGeneralLedgerCode;
  String? orderingFacilityGeneralLedgerCodes;
  String? orderingPhysicianFirstName;
  String? orderingPhysicianLastName;
  String? orderingPhysicianTitle;
  String? requesterEmail;
  String? requesterFirstName;
  String? requesterLastName;
  String? orderNotes;
  String? confirmGeneralLedgerCode;
  String? nationalUserIdentification;
  int? orderStatus;
  String? orderStatusName;
  String? completionTime;
  String? feedback;
  String? placementTime;
  int? incompleteOrderStatus;
  String? incompleteOrderStatusName;
  int? userId;
  int? technicianId;
  String? technicianName;
  int? orderAssignStatus;
  String? orderAssignStatusName;
  String? startTime;
  String? pickupTime;
  String? deliveryTime;
  int? labId;
  String? labName;
  String? labOwnerName;
  String? labContactNumber;
  String? labEmail;
  String? labAddress;
  String? imageSignatureUrl;
  String? labCity;
  double? labLatitude;
  double? labLongitude;
  List<dynamic>? orderAlternateRequesters; // Fixed here
  List<OrderTestRequests>? orderTestRequests;
  OrderTechnicianLocation? orderTechnicianLocation;
  List<OrderDeliveredMedia>? orderDeliveredMedia;

  FullOrder({
    this.patientId,
    this.firstName,
    this.lastName,
    this.mrNnumber,
    this.dateOfBirth,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.cellNumber,
    this.homeNumber,
    this.patientSpecialInstructions,
    this.orderId,
    this.orderNo,
    this.serviceType,
    this.serviceTypeName,
    this.quantityRequested,
    this.dateRequested,
    this.timeRequested,
    this.isHomeVisit,
    this.isEmergency,
    this.isPickupLocationSame,
    this.specimenPickupAddress,
    this.specimenPickupCity,
    this.specimenPickupState,
    this.specimenPickupZip,
    this.orderingFacilityDepartmentName,
    this.orderingFacilityPhoneNo,
    this.orderType,
    this.orderTypeName,
    this.orderingFacilityName,
    this.orderingFacilityNames,
    this.orderingFacilityGeneralLedgerCode,
    this.orderingFacilityGeneralLedgerCodes,
    this.orderingPhysicianFirstName,
    this.orderingPhysicianLastName,
    this.orderingPhysicianTitle,
    this.requesterEmail,
    this.requesterFirstName,
    this.requesterLastName,
    this.orderNotes,
    this.confirmGeneralLedgerCode,
    this.nationalUserIdentification,
    this.orderStatus,
    this.orderStatusName,
    this.completionTime,
    this.feedback,
    this.placementTime,
    this.incompleteOrderStatus,
    this.incompleteOrderStatusName,
    this.userId,
    this.technicianId,
    this.technicianName,
    this.orderAssignStatus,
    this.orderAssignStatusName,
    this.startTime,
    this.pickupTime,
    this.deliveryTime,
    this.labId,
    this.labName,
    this.labOwnerName,
    this.labContactNumber,
    this.labEmail,
    this.labAddress,
    this.labCity,
    this.labLatitude,
    this.labLongitude,
    this.orderAlternateRequesters,
    this.orderTestRequests,
    this.orderTechnicianLocation,
    this.imageSignatureUrl,
    this.orderDeliveredMedia,
  });

  FullOrder.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mrNnumber = json['mrNnumber'];
    dateOfBirth = json['dateOfBirth'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    cellNumber = json['cellNumber'];
    homeNumber = json['homeNumber'];
    patientSpecialInstructions = json['patientSpecialInstructions'];
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    serviceType = json['serviceType'];
    serviceTypeName = json['serviceTypeName'];
    quantityRequested = json['quantityRequested'];
    dateRequested = json['dateRequested'];
    timeRequested = json['timeRequested'];
    isHomeVisit = json['isHomeVisit'];
    isEmergency = json['isEmergency'];
    isPickupLocationSame = json['isPickupLocationSame'];
    specimenPickupAddress = json['specimenPickupAddress'];
    specimenPickupCity = json['specimenPickupCity'];
    specimenPickupState = json['specimenPickupState'];
    specimenPickupZip = json['specimenPickupZip'];
    orderingFacilityDepartmentName = json['orderingFacilityDepartmentName'];
    orderingFacilityPhoneNo = json['orderingFacilityPhoneNo'];
    orderType = json['orderType'];
    orderTypeName = json['orderTypeName'];
    orderingFacilityName = json['orderingFacilityName'];
    orderingFacilityNames = json['orderingFacilityNames'];
    orderingFacilityGeneralLedgerCode = json['orderingFacilityGeneralLedgerCode'];
    orderingFacilityGeneralLedgerCodes = json['orderingFacilityGeneralLedgerCodes'];
    orderingPhysicianFirstName = json['orderingPhysicianFirstName'];
    orderingPhysicianLastName = json['orderingPhysicianLastName'];
    orderingPhysicianTitle = json['orderingPhysicianTitle'];
    requesterEmail = json['requesterEmail'];
    requesterFirstName = json['requesterFirstName'];
    requesterLastName = json['requesterLastName'];
    orderNotes = json['orderNotes'];
    confirmGeneralLedgerCode = json['confirmGeneralLedgerCode'];
    nationalUserIdentification = json['nationalUserIdentification'];
    orderStatus = json['orderStatus'];
    orderStatusName = json['orderStatusName'];
    completionTime = json['completionTime'];
    feedback = json['feedback'];
    placementTime = json['placementTime'];
    incompleteOrderStatus = json['incompleteOrderStatus'];
    incompleteOrderStatusName = json['incompleteOrderStatusName'];
    userId = json['userId'];
    technicianId = json['technicianId'];
    technicianName = json['technicianName'];
    orderAssignStatus = json['orderAssignStatus'];
    orderAssignStatusName = json['orderAssignStatusName'];
    startTime = json['startTime'];
    pickupTime = json['pickupTime'];
    deliveryTime = json['deliveryTime'];
    labId = json['labId'];
    labName = json['labName'];
    labOwnerName = json['labOwnerName'];
    labContactNumber = json['labContactNumber'];
    labEmail = json['labEmail'];
    labAddress = json['labAddress'];
    labCity = json['labCity'];
    imageSignatureUrl = json['imageSignatureUrl'];
    labLatitude = json['labLatitude']?.toDouble();
    labLongitude = json['labLongitude']?.toDouble();
    orderAlternateRequesters = json['orderAlternateRequesters'];
    if (json['orderTestRequests'] != null) {
      orderTestRequests = <OrderTestRequests>[];
      json['orderTestRequests'].forEach((v) {
        orderTestRequests!.add(OrderTestRequests.fromJson(v));
      });
    }
    orderTechnicianLocation = json['orderTechnicianLocation'] != null
        ? OrderTechnicianLocation.fromJson(json['orderTechnicianLocation'])
        : null;
    if (json['orderDeliveredMedia'] != null) {
      orderDeliveredMedia = <OrderDeliveredMedia>[];
      json['orderDeliveredMedia'].forEach((v) {
        orderDeliveredMedia!.add(OrderDeliveredMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['patientId'] = patientId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['mrNnumber'] = mrNnumber;
    data['dateOfBirth'] = dateOfBirth;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    data['cellNumber'] = cellNumber;
    data['homeNumber'] = homeNumber;
    data['patientSpecialInstructions'] = patientSpecialInstructions;
    data['orderId'] = orderId;
    data['orderNo'] = orderNo;
    data['serviceType'] = serviceType;
    data['serviceTypeName'] = serviceTypeName;
    data['quantityRequested'] = quantityRequested;
    data['dateRequested'] = dateRequested;
    data['timeRequested'] = timeRequested;
    data['isHomeVisit'] = isHomeVisit;
    data['isEmergency'] = isEmergency;
    data['isPickupLocationSame'] = isPickupLocationSame;
    data['specimenPickupAddress'] = specimenPickupAddress;
    data['specimenPickupCity'] = specimenPickupCity;
    data['specimenPickupState'] = specimenPickupState;
    data['specimenPickupZip'] = specimenPickupZip;
    data['orderingFacilityDepartmentName'] = orderingFacilityDepartmentName;
    data['orderingFacilityPhoneNo'] = orderingFacilityPhoneNo;
    data['orderType'] = orderType;
    data['orderTypeName'] = orderTypeName;
    data['orderingFacilityName'] = orderingFacilityName;
    data['orderingFacilityNames'] = orderingFacilityNames;
    data['orderingFacilityGeneralLedgerCode'] = orderingFacilityGeneralLedgerCode;
    data['orderingFacilityGeneralLedgerCodes'] = orderingFacilityGeneralLedgerCodes;
    data['orderingPhysicianFirstName'] = orderingPhysicianFirstName;
    data['orderingPhysicianLastName'] = orderingPhysicianLastName;
    data['orderingPhysicianTitle'] = orderingPhysicianTitle;
    data['requesterEmail'] = requesterEmail;
    data['requesterFirstName'] = requesterFirstName;
    data['requesterLastName'] = requesterLastName;
    data['orderNotes'] = orderNotes;
    data['confirmGeneralLedgerCode'] = confirmGeneralLedgerCode;
    data['nationalUserIdentification'] = nationalUserIdentification;
    data['orderStatus'] = orderStatus;
    data['orderStatusName'] = orderStatusName;
    data['completionTime'] = completionTime;
    data['feedback'] = feedback;
    data['placementTime'] = placementTime;
    data['incompleteOrderStatus'] = incompleteOrderStatus;
    data['incompleteOrderStatusName'] = incompleteOrderStatusName;
    data['userId'] = userId;
    data['technicianId'] = technicianId;
    data['technicianName'] = technicianName;
    data['orderAssignStatus'] = orderAssignStatus;
    data['orderAssignStatusName'] = orderAssignStatusName;
    data['startTime'] = startTime;
    data['pickupTime'] = pickupTime;
    data['deliveryTime'] = deliveryTime;
    data['labId'] = labId;
    data['labName'] = labName;
    data['labOwnerName'] = labOwnerName;
    data['labContactNumber'] = labContactNumber;
    data['labEmail'] = labEmail;
    data['labAddress'] = labAddress;
    data['labCity'] = labCity;
    data['labLatitude'] = labLatitude;
    data['labLongitude'] = labLongitude;
    data['orderAlternateRequesters'] = orderAlternateRequesters;
    if (orderTestRequests != null) {
      data['orderTestRequests'] = orderTestRequests!.map((v) => v.toJson()).toList();
    }
    if (orderTechnicianLocation != null) {
      data['orderTechnicianLocation'] = orderTechnicianLocation!.toJson();
    }
    if (orderDeliveredMedia != null) {
      data['orderDeliveredMedia'] = orderDeliveredMedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderTestRequests {
  String? testRequestedName;
  int? orderId;
  int? testRequested;
  bool? isFasting;

  OrderTestRequests(
      {this.testRequestedName,
      this.orderId,
      this.testRequested,
      this.isFasting});

  OrderTestRequests.fromJson(Map<String, dynamic> json) {
    testRequestedName = json['testRequestedName'];
    orderId = json['orderId'];
    testRequested = json['testRequested'];
    isFasting = json['isFasting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testRequestedName'] = this.testRequestedName;
    data['orderId'] = this.orderId;
    data['testRequested'] = this.testRequested;
    data['isFasting'] = this.isFasting;
    return data;
  }
}

class OrderDeliveredMedia {
  String? imageUrl;
  int? orderId;
  int? orderDeliveredMediaId;

  OrderDeliveredMedia(
      {this.imageUrl,
      this.orderId,
      this.orderDeliveredMediaId});

  OrderDeliveredMedia.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    orderId = json['orderId'];
    orderDeliveredMediaId = json['orderDeliveredMediaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['orderId'] = this.orderId;
    data['orderDeliveredMediaId'] = this.orderDeliveredMediaId;
    return data;
  }
}

class OrderTechnicianLocation {
  String? orderTrackingStatusName;
  int? orderTechnicianLocationId;
  int? userId;
  int? orderId;
  double? latitude;
  double? longitude;
  int? orderTrackingStatus;

  OrderTechnicianLocation(
      {this.orderTrackingStatusName,
      this.orderTechnicianLocationId,
      this.userId,
      this.orderId,
      this.latitude,
      this.longitude,
      this.orderTrackingStatus});

  OrderTechnicianLocation.fromJson(Map<String, dynamic> json) {
    orderTrackingStatusName = json['orderTrackingStatusName'];
    orderTechnicianLocationId = json['orderTechnicianLocationId'];
    userId = json['userId'];
    orderId = json['orderId'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    orderTrackingStatus = json['orderTrackingStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderTrackingStatusName'] = this.orderTrackingStatusName;
    data['orderTechnicianLocationId'] = this.orderTechnicianLocationId;
    data['userId'] = this.userId;
    data['orderId'] = this.orderId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['orderTrackingStatus'] = this.orderTrackingStatus;
    return data;
  }
}
