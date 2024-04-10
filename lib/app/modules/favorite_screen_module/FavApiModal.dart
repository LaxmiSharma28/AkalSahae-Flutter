// To parse this JSON data, do
//
//     final getFavListModel = getFavListModelFromJson(jsonString);

import 'dart:convert';

GetFavListModel getFavListModelFromJson(String str) => GetFavListModel.fromJson(json.decode(str));

String getFavListModelToJson(GetFavListModel data) => json.encode(data.toJson());

class GetFavListModel {
  bool? success;
  int? statusCode;
  List<Favorite>? favorites;

  GetFavListModel({
    this.success,
    this.statusCode,
    this.favorites,
  });

  factory GetFavListModel.fromJson(Map<String, dynamic> json) => GetFavListModel(
    success: json["success"],
    statusCode: json["status_code"],
    favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"]!.map((x) => Favorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x.toJson())),
  };
}

class Favorite {
  int? id;
  int? userId;
  int? productId;
  int? productVariationId;
  int? isFavorite;
  String? colorSlug;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  Favorite({
    this.id,
    this.userId,
    this.productId,
    this.productVariationId,
    this.isFavorite,
    this.colorSlug,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    productVariationId: json["product_variation_id"],
    isFavorite: json["is_favorite"],
    colorSlug: json["color_slug"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "product_variation_id": productVariationId,
    "is_favorite": isFavorite,
    "color_slug": colorSlug,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? productName;
  dynamic attributes;
  String? image;
  dynamic productImages;
  int? price;
  dynamic gstPercentage;
  dynamic discountOnMrp;
  String? status;
  int? hasVariation;
  int? lengthAvailable;
  String? endingLength;
  String? startingLength;
  int? stichingAvailable;
  String? stichingPrice;
  dynamic description;
  dynamic weight;
  dynamic quantity;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? categoryId;
  int? serialNumber;

  Product({
    this.id,
    this.productName,
    this.attributes,
    this.image,
    this.productImages,
    this.price,
    this.gstPercentage,
    this.discountOnMrp,
    this.status,
    this.hasVariation,
    this.lengthAvailable,
    this.endingLength,
    this.startingLength,
    this.stichingAvailable,
    this.stichingPrice,
    this.description,
    this.weight,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.categoryId,
    this.serialNumber,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productName: json["product_name"],
    attributes: json["attributes"],
    image: json["image"],
    productImages: json["product_images"],
    price: json["price"],
    gstPercentage: json["gst_percentage"],
    discountOnMrp: json["discount_on_mrp"],
    status: json["status"],
    hasVariation: json["has_variation"],
    lengthAvailable: json["length_available"],
    endingLength: json["ending_length"],
    startingLength: json["starting_length"],
    stichingAvailable: json["stiching_available"],
    stichingPrice: json["stiching_price"],
    description: json["description"],
    weight: json["weight"],
    quantity: json["quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    categoryId: json["category_id"],
    serialNumber: json["serial_number"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "attributes": attributes,
    "image": image,
    "product_images": productImages,
    "price": price,
    "gst_percentage": gstPercentage,
    "discount_on_mrp": discountOnMrp,
    "status": status,
    "has_variation": hasVariation,
    "length_available": lengthAvailable,
    "ending_length": endingLength,
    "starting_length": startingLength,
    "stiching_available": stichingAvailable,
    "stiching_price": stichingPrice,
    "description": description,
    "weight": weight,
    "quantity": quantity,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "category_id": categoryId,
    "serial_number": serialNumber,
  };
}






/*
import 'dart:convert';

GetFavListModel getFavListModelFromJson(String str) => GetFavListModel.fromJson(json.decode(str));

String getFavListModelToJson(GetFavListModel data) => json.encode(data.toJson());

class GetFavListModel {
  final bool? success;
  final int? statusCode;
  final List<dynamic>? favorites;

  GetFavListModel({
    this.success,
    this.statusCode,
    this.favorites,
  });

  factory GetFavListModel.fromJson(Map<String, dynamic> json) => GetFavListModel(
    success: json["success"],
    statusCode: json["status_code"],
    favorites: json["favorites"] == null ? [] : List<dynamic>.from(json["favorites"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x)),
  };
}
*/
