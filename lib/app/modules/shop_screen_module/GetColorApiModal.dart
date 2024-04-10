// To parse this JSON data, do
//
//     final getColorApiModal = getColorApiModalFromJson(jsonString);

import 'dart:convert';

GetColorApiModal getColorApiModalFromJson(String str) => GetColorApiModal.fromJson(json.decode(str));

String getColorApiModalToJson(GetColorApiModal data) => json.encode(data.toJson());

class GetColorApiModal {
  bool? success;
  int? statusCode;
  String? message;
  List<TurbanColors>? colors;

  GetColorApiModal({
    this.success,
    this.statusCode,
    this.message,
    this.colors,
  });

  factory GetColorApiModal.fromJson(Map<String, dynamic> json) => GetColorApiModal(
    success: json["success"],
    statusCode: json["status_code"],
    message: json["message"],
    colors: json["colors"] == null ? [] : List<TurbanColors>.from(json["colors"]!.map((x) => TurbanColors.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    "message": message,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x.toJson())),
  };
}

class TurbanColors {
  int? id;
  String? identityCode;
  String? colorName;
  String? image;
  String? slug;

  TurbanColors({
    this.id,
    this.identityCode,
    this.colorName,
    this.image,
    this.slug,
  });

  factory TurbanColors.fromJson(Map<String, dynamic> json) => TurbanColors(
    id: json["id"],
    identityCode: json["identity_code"],
    colorName: json["color_name"],
    image: json["image"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "identity_code": identityCode,
    "color_name": colorName,
    "image": image,
    "slug": slug,
  };
}





/*
import 'dart:convert';

GetColorApiModal getColorApiModalFromJson(String str) => GetColorApiModal.fromJson(json.decode(str));

String getColorApiModalToJson(GetColorApiModal data) => json.encode(data.toJson());

class GetColorApiModal {
  bool? success;
  int? statusCode;
  String? message;
  List<TurbanColors>? colors;

  GetColorApiModal({
    this.success,
    this.statusCode,
    this.message,
    this.colors,
  });

  factory GetColorApiModal.fromJson(Map<String, dynamic> json) => GetColorApiModal(
        success: json["success"],
        statusCode: json["status_code"],
        message: json["message"],
        colors:
            json["colors"] == null ? [] : List<TurbanColors>.from(json["colors"]!.map((x) => TurbanColors.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "message": message,
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x.toJson())),
      };
}

class TurbanColors {
  int? id;
  String? identityCode;
  String? colorName;
  String? images;

  TurbanColors({
    this.id,
    this.identityCode,
    this.colorName,
    this.images,
  });

  factory TurbanColors.fromJson(Map<String, dynamic> json) => TurbanColors(
        id: json["id"],
        identityCode: json["identity_code"],
        colorName: json["color_name"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identity_code": identityCode,
        "color_name": colorName,
        "images": images,
      };
}

*/
/*
class GetColorApiModal {
  bool? success;
  int? statusCode;
  List<TurbanColors>? colors;

  GetColorApiModal({this.success, this.statusCode, this.colors});

  GetColorApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['colors'] != null) {
      colors = <TurbanColors>[];
      json['colors'].forEach((v) {
        colors!.add(new TurbanColors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TurbanColors {
  int? id;
  String? hexCode;
  String? identityCode;
  String? colorName;
  List<Images>? images;

  TurbanColors({this.id, this.hexCode, this.identityCode, this.colorName, this.images});

  TurbanColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hexCode = json['hex_code'];
    identityCode = json['identity_code'];
    colorName = json['color_name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hex_code'] = this.hexCode;
    data['identity_code'] = this.identityCode;
    data['color_name'] = this.colorName;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
*/

