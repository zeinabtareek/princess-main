// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

List<OfferModel> offerModelFromJson(String str) => List<OfferModel>.from(json.decode(str).map((x) => OfferModel.fromJson(x)));

String offerModelToJson(List<OfferModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OfferModel {
  OfferModel({
    required this.id,
    required this.name,
    required this.price,
    required this.minPrice,
    required  this.photo,
    required this.shortDescription,
    required  this.description,
  });

  int id;
  String name;
  String price;
  String minPrice;
  List<String> photo;
  String shortDescription;
  String description;

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    minPrice: json["min_price"],
    photo: List<String>.from(json["photo"].map((x) => x)),
    shortDescription: json["short_description"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "min_price": minPrice,
    "photo": List<dynamic>.from(photo.map((x) => x)),
    "short_description": shortDescription,
    "description": description,
  };
}
