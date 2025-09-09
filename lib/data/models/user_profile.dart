import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    int userId;
    String role;
    int availabilityStatus;
    bool isActive;
    String firstName;
    String lastName;
    String email;
    String phoneNumber;
    String ssn;
    String emergencyContact;
    String currentAddress;
    String permanentAddress;
    String licenseNumber;
    String licenseFrontPhoto;
    String licenseBackPhoto;
    int irsTaxForm;

    UserProfile({
        required this.userId,
        required this.role,
        required this.availabilityStatus,
        required this.isActive,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.ssn,
        required this.emergencyContact,
        required this.currentAddress,
        required this.permanentAddress,
        required this.licenseNumber,
        required this.licenseFrontPhoto,
        required this.licenseBackPhoto,
        required this.irsTaxForm,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["userId"],
        role: json["role"],
        availabilityStatus: json["availabilityStatus"],
        isActive: json["isActive"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        ssn: json["ssn"],
        emergencyContact: json["emergencyContact"],
        currentAddress: json["currentAddress"],
        permanentAddress: json["permanentAddress"],
        licenseNumber: json["licenseNumber"],
        licenseFrontPhoto: json["licenseFrontPhoto"],
        licenseBackPhoto: json["licenseBackPhoto"],
        irsTaxForm: json["irsTaxForm"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "role": role,
        "availabilityStatus": availabilityStatus,
        "isActive": isActive,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "ssn": ssn,
        "emergencyContact": emergencyContact,
        "currentAddress": currentAddress,
        "permanentAddress": permanentAddress,
        "licenseNumber": licenseNumber,
        "licenseFrontPhoto": licenseFrontPhoto,
        "licenseBackPhoto": licenseBackPhoto,
        "irsTaxForm": irsTaxForm,
    };
}
