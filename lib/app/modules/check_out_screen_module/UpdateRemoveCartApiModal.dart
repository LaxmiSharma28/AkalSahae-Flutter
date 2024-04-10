class RemoveCartApiModal {
  bool? success;
  int? statusCode;
  String? message;

  RemoveCartApiModal({this.success, this.statusCode, this.message});

  RemoveCartApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}




/*
class UpdateRemoveCartApiModal {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  UpdateRemoveCartApiModal(
      {this.success, this.statusCode, this.message, this.data});

  UpdateRemoveCartApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? deviceId;
  int? productId;
  int? variationId;
  int? colorId;
  int? brandId;
  int? clothId;
  String? price;
  int? quantity;
  int? totalPrice;
  Null? discountOnMrp;
  String? size;
  int? centerStitch;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.deviceId,
        this.productId,
        this.variationId,
        this.colorId,
        this.brandId,
        this.clothId,
        this.price,
        this.quantity,
        this.totalPrice,
        this.discountOnMrp,
        this.size,
        this.centerStitch,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    colorId = json['color_id'];
    brandId = json['brand_id'];
    clothId = json['cloth_id'];
    price = json['price'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    discountOnMrp = json['discount_on_mrp'];
    size = json['size'];
    centerStitch = json['center_stitch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['device_id'] = this.deviceId;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    data['color_id'] = this.colorId;
    data['brand_id'] = this.brandId;
    data['cloth_id'] = this.clothId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['total_price'] = this.totalPrice;
    data['discount_on_mrp'] = this.discountOnMrp;
    data['size'] = this.size;
    data['center_stitch'] = this.centerStitch;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/
