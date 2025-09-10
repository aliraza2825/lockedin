class Order {
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
  int? orderId;
  String? orderNo;
  String? dateRequested;
  String? timeRequested;
  bool? isPickupLocationSame;
  String? specimenPickupAddress;
  String? specimenPickupCity;
  String? specimenPickupState;
  String? specimenPickupZip;
  String? placementTime;
  int? userId;
  int? technicianId;
  String? technicianName;
  int? orderAssignStatus;
  String? orderAssignStatusName;
  int? orderStatus;
  String? orderStatusName;
  int? labId;
  String? labName;
  String? labOwnerName;
  String? labContactNumber;
  String? labEmail;
  String? labAddress;
  String? labCity;
  double? labLatitude;
  double? labLongitude;
  OrderTechnicianLocation? orderTechnicianLocation;
  double? distanceInKm;
  double? pickupLatitude;
  double? pickupLongitude;

  Order(
      {this.patientId,
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
      this.orderId,
      this.orderNo,
      this.dateRequested,
      this.timeRequested,
      this.isPickupLocationSame,
      this.specimenPickupAddress,
      this.specimenPickupCity,
      this.specimenPickupState,
      this.specimenPickupZip,
      this.placementTime,
      this.userId,
      this.technicianId,
      this.technicianName,
      this.orderAssignStatus,
      this.orderAssignStatusName,
      this.orderStatus,
      this.orderStatusName,
      this.labId,
      this.labName,
      this.labOwnerName,
      this.labContactNumber,
      this.labEmail,
      this.labAddress,
      this.labCity,
      this.labLatitude,
      this.labLongitude,
      this.orderTechnicianLocation});

  Order.fromJson(Map<String, dynamic> json) {
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
    orderId = json['orderId'];
    orderNo = json['orderNo'];
    dateRequested = json['dateRequested'];
    timeRequested = json['timeRequested'];
    isPickupLocationSame = json['isPickupLocationSame'];
    specimenPickupAddress = json['specimenPickupAddress'];
    specimenPickupCity = json['specimenPickupCity'];
    specimenPickupState = json['specimenPickupState'];
    specimenPickupZip = json['specimenPickupZip'];
    placementTime = json['placementTime'];
    userId = json['userId'];
    technicianId = json['technicianId'];
    technicianName = json['technicianName'];
    orderAssignStatus = json['orderAssignStatus'];
    orderAssignStatusName = json['orderAssignStatusName'];
    orderStatus = json['orderStatus'];
    orderStatusName = json['orderStatusName'];
    labId = json['labId'];
    labName = json['labName'];
    labOwnerName = json['labOwnerName'];
    labContactNumber = json['labContactNumber'];
    labEmail = json['labEmail'];
    labAddress = json['labAddress'];
    labCity = json['labCity'];
    labLatitude = json['labLatitude'];
    labLongitude = json['labLongitude'];
    orderTechnicianLocation = json['orderTechnicianLocation'] != null
        ? OrderTechnicianLocation.fromJson(json['orderTechnicianLocation'])
        : null;
    distanceInKm = 0.0;
    pickupLatitude = null;
    pickupLongitude = null;  
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mrNnumber'] = this.mrNnumber;
    data['dateOfBirth'] = this.dateOfBirth;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zipCode'] = this.zipCode;
    data['cellNumber'] = this.cellNumber;
    data['homeNumber'] = this.homeNumber;
    data['orderId'] = this.orderId;
    data['orderNo'] = this.orderNo;
    data['dateRequested'] = this.dateRequested;
    data['timeRequested'] = this.timeRequested;
    data['isPickupLocationSame'] = this.isPickupLocationSame;
    data['specimenPickupAddress'] = this.specimenPickupAddress;
    data['specimenPickupCity'] = this.specimenPickupCity;
    data['specimenPickupState'] = this.specimenPickupState;
    data['specimenPickupZip'] = this.specimenPickupZip;
    data['placementTime'] = this.placementTime;
    data['userId'] = this.userId;
    data['technicianId'] = this.technicianId;
    data['technicianName'] = this.technicianName;
    data['orderAssignStatus'] = this.orderAssignStatus;
    data['orderAssignStatusName'] = this.orderAssignStatusName;
    data['orderStatus'] = this.orderStatus;
    data['orderStatusName'] = this.orderStatusName;
    data['labId'] = this.labId;
    data['labName'] = this.labName;
    data['labOwnerName'] = this.labOwnerName;
    data['labContactNumber'] = this.labContactNumber;
    data['labEmail'] = this.labEmail;
    data['labAddress'] = this.labAddress;
    data['labCity'] = this.labCity;
    data['labLatitude'] = this.labLatitude;
    data['labLongitude'] = this.labLongitude;
    if (this.orderTechnicianLocation != null) {
      data['orderTechnicianLocation'] = this.orderTechnicianLocation!.toJson();
    }
    data['distanceInKm'] = this.distanceInKm;
    data['pickupLatitude'] = this.pickupLatitude;
    data['pickupLongitude'] = this.pickupLongitude;
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
