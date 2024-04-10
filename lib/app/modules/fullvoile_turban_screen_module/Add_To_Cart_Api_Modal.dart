// To parse this JSON data, do
//
//     final addToCartApiModal = addToCartApiModalFromJson(jsonString);

import 'dart:convert';

AddToCartApiModal addToCartApiModalFromJson(String str) => AddToCartApiModal.fromJson(json.decode(str));

String addToCartApiModalToJson(AddToCartApiModal data) => json.encode(data.toJson());

class AddToCartApiModal {
  bool? success;
  int? statusCode;
  String? message;

  AddToCartApiModal({
    this.success,
    this.statusCode,
    this.message,
  });

  factory AddToCartApiModal.fromJson(Map<String, dynamic> json) => AddToCartApiModal(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
  };
}
