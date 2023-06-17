// To parse this JSON data, do
//
//     final userDetailsResponse = userDetailsResponseFromJson(jsonString);

import 'dart:convert';

UserDetailsResponse userDetailsResponseFromJson(String str) => UserDetailsResponse.fromJson(json.decode(str));

String userDetailsResponseToJson(UserDetailsResponse data) => json.encode(data.toJson());

class UserDetailsResponse {
    String? pk;
    String? email;
    String? name;
    bool isStaff;
    String? picture;

    UserDetailsResponse({
        this.pk,
        this.email,
        this.name,
        required this.isStaff,
        this.picture,
    });

    factory UserDetailsResponse.fromJson(Map<String, dynamic> json) => UserDetailsResponse(
        pk: json["pk"],
        email: json["email"],
        name: json["name"],
        isStaff: json["is_staff"],
        picture: json["picture"],
    );

    Map<String, dynamic> toJson() => {
        "pk": pk,
        "email": email,
        "name": name,
        "is_staff": isStaff,
        "picture": picture,
    };
}
