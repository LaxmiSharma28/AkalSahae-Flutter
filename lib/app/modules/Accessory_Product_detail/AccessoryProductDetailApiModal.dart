// To parse this JSON data, do
//
//     final accessoryProductDetailApiModal = accessoryProductDetailApiModalFromJson(jsonString);

import 'dart:convert';

AccessoryProductDetailApiModal accessoryProductDetailApiModalFromJson(String str) => AccessoryProductDetailApiModal.fromJson(json.decode(str));

String accessoryProductDetailApiModalToJson(AccessoryProductDetailApiModal data) => json.encode(data.toJson());

class AccessoryProductDetailApiModal {
  bool? success;
  int? statusCode;
  ProductData? data;

  AccessoryProductDetailApiModal({
    this.success,
    this.statusCode,
    this.data,
  });

  factory AccessoryProductDetailApiModal.fromJson(Map<String, dynamic> json) => AccessoryProductDetailApiModal(
    success: json["success"],
    statusCode: json["status_code"],
    data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "data": data?.toJson(),
  };
}

class ProductData {
  int? id;
  String? productName;
  dynamic attributes;
  String? image;
  List<Image>? images;
  int? price;
  dynamic gstPercentage;
  int? discountOnMrp;
  String? status;
  int? hasVariation;
  dynamic lengthAvailable;
  dynamic endingLength;
  dynamic startingLength;
  dynamic stichingAvailable;
  dynamic stichingPrice;
  String? description;
  dynamic weight;
  String? quantity;
  ProductVariations? productVariations;
  bool? isFavorite;
  List<dynamic>? length;

  ProductData({
    this.id,
    this.productName,
    this.attributes,
    this.image,
    this.images,
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
    this.productVariations,
    this.isFavorite,
    this.length,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    productName: json["product_name"],
    attributes: json["attributes"],
    image: json["image"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
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
    productVariations: json["product_variations"] == null ? null : ProductVariations.fromJson(json["product_variations"]),
    isFavorite: json["is_favorite"],
    length: json["length"] == null ? [] : List<dynamic>.from(json["length"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "attributes": attributes,
    "image": image,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
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
    "product_variations": productVariations?.toJson(),
    "is_favorite": isFavorite,
    "length": length == null ? [] : List<dynamic>.from(length!.map((x) => x)),
  };
}

class Image {
  String? url;

  Image({
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
  };
}

class ProductVariations {
  String? key;
  List<BrandData>? data;

  ProductVariations({
    this.key,
    this.data,
  });

  factory ProductVariations.fromJson(Map<String, dynamic> json) => ProductVariations(
    key: json["key"],
    data: json["data"] == null ? [] : List<BrandData>.from(json["data"]!.map((x) => BrandData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BrandData {
  int? id;
  int? productId;
  dynamic colorId;
  String? brandId;
  String? brandPrice;
  String? brandName;
  List<Image>? images;
  int? attributeId;
  String? attributeName;
  int? attributeValue;
  String? price;
  String? gstPercentage;
  String? quantity;
  String? weight;
  dynamic discountOnMrp;
  String? description;
  String? outOfStock;

  BrandData({
    this.id,
    this.productId,
    this.colorId,
    this.brandId,
    this.brandPrice,
    this.brandName,
    this.images,
    this.attributeId,
    this.attributeName,
    this.attributeValue,
    this.price,
    this.gstPercentage,
    this.quantity,
    this.weight,
    this.discountOnMrp,
    this.description,
    this.outOfStock,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
    id: json["id"],
    productId: json["product_id"],
    colorId: json["color_id"],
    brandId: json["brand_id"],
    brandPrice: json["brand_price"],
    brandName: json["brand_name"],
    images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
    attributeId: json["attribute_id"],
    attributeName: json["attribute_name"],
    attributeValue: json["attribute_value"],
    price: json["price"],
    gstPercentage: json["gst_percentage"],
    quantity: json["quantity"],
    weight: json["weight"],
    discountOnMrp: json["discount_on_mrp"],
    description: json["description"],
    outOfStock: json["out_of_stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "color_id": colorId,
    "brand_id": brandId,
    "brand_price": brandPrice,
    "brand_name": brandName,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "attribute_id": attributeId,
    "attribute_name": attributeName,
    "attribute_value": attributeValue,
    "price": price,
    "gst_percentage": gstPercentage,
    "quantity": quantity,
    "weight": weight,
    "discount_on_mrp": discountOnMrp,
    "description": description,
    "out_of_stock": outOfStock,
  };
}

















/*


import 'dart:convert';

AccessoryProductDetailApiModal accessoryProductDetailApiModalFromJson(String str) =>
    AccessoryProductDetailApiModal.fromJson(json.decode(str));

String accessoryProductDetailApiModalToJson(AccessoryProductDetailApiModal data) => json.encode(data.toJson());

class AccessoryProductDetailApiModal {
  bool? success;
  int? statusCode;
  ProductData? data;

  AccessoryProductDetailApiModal({
    this.success,
    this.statusCode,
    this.data,
  });

  factory AccessoryProductDetailApiModal.fromJson(Map<String, dynamic> json) => AccessoryProductDetailApiModal(
        success: json["success"],
        statusCode: json["status_code"],
        data: json["data"] == null ? null : ProductData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "data": data?.toJson(),
      };
}

class ProductData {
  int? id;
  String? productName;
  String? image;
  List<Image>? images;
  int? price;
  int? discountOnMrp;
  String? status;
  int? hasVariation;
  String? description;
  ProductVariations? productVariations;
  bool? isFavorite;
  List<Length>? length;

  ProductData({
    this.id,
    this.productName,
    this.image,
    this.images,
    this.price,
    this.discountOnMrp,
    this.status,
    this.hasVariation,
    this.description,
    this.productVariations,
    this.isFavorite,
    this.length,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        id: json["id"],
        productName: json["product_name"],
        image: json["image"],
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        price: json["price"],
        discountOnMrp: json["discount_on_mrp"],
        status: json["status"],
        hasVariation: json["has_variation"],
        description: json["description"],
        productVariations:
            json["product_variations"] == null ? null : json["product_variations"].isEmpty ?null: ProductVariations.fromJson(json["product_variations"]),
        isFavorite: json["is_favorite"],
        length: json["length"] == null ? [] : List<Length>.from(json["length"]!.map((x) => Length.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "image": image,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "price": price,
        "discount_on_mrp": discountOnMrp,
        "status": status,
        "has_variation": hasVariation,
        "description": description,
        "product_variations": productVariations?.toJson(),
        "is_favorite": isFavorite,
        "length": length == null ? [] : List<dynamic>.from(length!.map((x) => x.toJson())),
      };
}

class Image {
  String? url;

  Image({
    this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Length {
  String? key;

  Length({
    this.key,
  });

  factory Length.fromJson(Map<String, dynamic> json) => Length(
        key: json["Key"],
      );

  Map<String, dynamic> toJson() => {
        "Key": key,
      };
}

class ProductVariations {
  String? key;
  List<BrandData>? data;

  ProductVariations({
    this.key,
    this.data,
  });

  factory ProductVariations.fromJson(Map<String, dynamic> json) => ProductVariations(
        key: json["key"],
        data: json["data"] == null ? [] : List<BrandData>.from(json["data"]!.map((x) => BrandData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BrandData {
  int? id;
  int? productId;
  dynamic colorId;
  String? brandId;
  String? brandPrice;
  String? brandName;
  List<Image>? images;
  int? attributeId;
  String? attributeName;
  int? attributeValue;
  String? price;
  String? gstPercentage;
  String? quantity;
  String? weight;
  dynamic discountOnMrp;
  String? description;
  bool? isFavorite;

  BrandData({
    this.id,
    this.productId,
    this.colorId,
    this.brandId,
    this.brandPrice,
    this.brandName,
    this.images,
    this.attributeId,
    this.attributeName,
    this.attributeValue,
    this.price,
    this.gstPercentage,
    this.quantity,
    this.weight,
    this.discountOnMrp,
    this.description,
    this.isFavorite,
  });

  factory BrandData.fromJson(Map<String, dynamic> json) => BrandData(
        id: json["id"],
        productId: json["product_id"],
        colorId: json["color_id"],
        brandId: json["brand_id"],
        brandPrice: json["brand_price"],
        brandName: json["brand_name"],
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        attributeId: json["attribute_id"],
        attributeName: json["attribute_name"],
        attributeValue: json["attribute_value"],
        price: json["price"],
        gstPercentage: json["gst_percentage"],
        quantity: json["quantity"],
        weight: json["weight"],
        discountOnMrp: json["discount_on_mrp"],
        description: json["description"],
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "color_id": colorId,
        "brand_id": brandId,
        "brand_price": brandPrice,
        "brand_name": brandName,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "attribute_id": attributeId,
        "attribute_name": attributeName,
        "attribute_value": attributeValue,
        "price": price,
        "gst_percentage": gstPercentage,
        "quantity": quantity,
        "weight": weight,
        "discount_on_mrp": discountOnMrp,
        "description": description,
        "is_favorite": isFavorite,
      };
}

*/
