// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) => List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel({
    required this.id,
    required this.offerName,
    required this.price,
    required this.createdAt,
    required  this.status,
    required  this.date,
    required this.photo,
    required this.description,
  });

  int id;
  String offerName;
  String price;
  DateTime createdAt;
  String status;
  DateTime date;
  List<String> photo;
  String description;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    offerName: json["offer_name"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    status: json["status"],
    date: DateTime.parse(json["date"]),
    photo: List<String>.from(json["photo"].map((x) => x)),
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "offer_name": offerName,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "status": status,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "photo": List<dynamic>.from(photo.map((x) => x)),
    "description": description,
  };
}
