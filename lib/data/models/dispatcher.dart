class Dispatcher {
  int? userId;
  bool? isAccountApproved;
  bool? isActive;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? streetAddress;
  String? city;
  String? state;
  String? zipCode;

  Dispatcher(
      {this.userId,
      this.isAccountApproved,
      this.isActive,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.streetAddress,
      this.city,
      this.state,
      this.zipCode});

  Dispatcher.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    isAccountApproved = json['isAccountApproved'];
    isActive = json['isActive'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    streetAddress = json['streetAddress'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['isAccountApproved'] = isAccountApproved;
    data['isActive'] = isActive;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['streetAddress'] = streetAddress;
    data['city'] = city;
    data['state'] = state;
    data['zipCode'] = zipCode;
    return data;
  }
}
