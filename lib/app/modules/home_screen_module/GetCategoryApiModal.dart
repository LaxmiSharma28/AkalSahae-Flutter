// To parse this JSON data, do
//
//     final getHomeCategoryApiModal = getHomeCategoryApiModalFromJson(jsonString);

import 'dart:convert';

GetCategoryApiModal getHomeCategoryApiModalFromJson(String str) => GetCategoryApiModal.fromJson(json.decode(str));

String getHomeCategoryApiModalToJson(GetCategoryApiModal data) => json.encode(data.toJson());

class GetCategoryApiModal {
  bool? success;
  int? statusCode;
  String? message;
  List<ClothType>? data;
  List<Banner>? banner;

  GetCategoryApiModal({
    this.success,
    this.statusCode,
    this.message,
    this.data,
    this.banner,
  });

  factory GetCategoryApiModal.fromJson(Map<String, dynamic> json) => GetCategoryApiModal(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    data: json["data"] == null ? [] : List<ClothType>.from(json["data"]!.map((x) => ClothType.fromJson(x))),
    banner: json["banner"] == null ? [] : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "banner": banner == null ? [] : List<dynamic>.from(banner!.map((x) => x.toJson())),
  };
}

class Banner {
  int? id;
  String? name;
  String? bannerImages;
  String? bannerUrl;

  Banner({
    this.id,
    this.name,
    this.bannerImages,
    this.bannerUrl,
  });

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    name: json["name"],
    bannerImages: json["banner_images"],
    bannerUrl: json["banner_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "banner_images": bannerImages,
    "banner_url": bannerUrl,
  };
}

class ClothType {
  int? id;
  String? productName;
  String? image;
  int? isProduct;

  ClothType({
    this.id,
    this.productName,
    this.image,
    this.isProduct,
  });

  factory ClothType.fromJson(Map<String, dynamic> json) => ClothType(
    id: json["id"],
    productName: json["product_name"],
    image: json["image"],
    isProduct: json["is_product"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "image": image,
    "is_product": isProduct,
  };
}



/*class GetCategoryApiModal {
  bool? success;
  int? statusCode;
  Data? data;

  GetCategoryApiModal({this.success, this.statusCode, this.data});

  GetCategoryApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ClothType>? clothType;
  BannerDetails? bannerDetails;

  Data({this.clothType, this.bannerDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['cloth_type'] != null) {
      clothType = <ClothType>[];
      json['cloth_type'].forEach((v) {
        clothType!.add(new ClothType.fromJson(v));
      });
    }
    bannerDetails = json['banner_details'] != null ? new BannerDetails.fromJson(json['banner_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.clothType != null) {
      data['cloth_type'] = this.clothType!.map((v) => v.toJson()).toList();
    }
    if (this.bannerDetails != null) {
      data['banner_details'] = this.bannerDetails!.toJson();
    }
    return data;
  }
}

class ClothType {
  int? id;
  String? name;
  String? image;
  int? categoryId;

  ClothType({this.id, this.name, this.image, this.categoryId});

  ClothType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    return data;
  }
}

class BannerDetails {
  String? bannerImage;
  String? bannerUrl;

  BannerDetails({this.bannerImage, this.bannerUrl});

  BannerDetails.fromJson(Map<String, dynamic> json) {
    bannerImage = json['banner_image'];
    bannerUrl = json['banner_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_image'] = this.bannerImage;
    data['banner_url'] = this.bannerUrl;
    return data;
  }
}*/


