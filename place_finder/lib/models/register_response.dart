// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) => RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) => json.encode(data.toJson());

class RegisterResponse {
    List<String>? name;
    List<String>? email;
    List<String>? password;

    //constructor class
    RegisterResponse({
         this.name,
        this.email,
        this.password,
    });

    factory RegisterResponse.fromJson(Map<String, dynamic> json) => RegisterResponse(
        name: List<String>.from(json["name"].map((x) => x)),
        email: List<String>.from(json["email"].map((x) => x)),
        password: List<String>.from(json["password"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "name": List<dynamic>.from(name!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
        "password": List<dynamic>.from(password!.map((x) => x)),
    };
}
