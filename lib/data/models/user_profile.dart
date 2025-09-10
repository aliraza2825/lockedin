import 'dart:convert';

UserProfile userProfileFromJson(String str) => UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
    int userId;
    String firstName;
    String lastName;
    String email;
    String phoneNumber;
    String currentAddress;

    UserProfile({
        required this.userId,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.currentAddress,
    });

    factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        currentAddress: json["currentAddress"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phoneNumber": phoneNumber,
        "currentAddress": currentAddress,
    };
}
