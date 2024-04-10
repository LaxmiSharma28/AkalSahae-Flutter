class PlaceOrderApiModal {
  bool? status;
  String? message;
  int? statusCode;
  Data? data;

  PlaceOrderApiModal({this.status, this.message, this.statusCode, this.data});

  PlaceOrderApiModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? orderId;
  String? addressId;
  int? userId;
  List<CartItems>? cartItems;
  Address? address;
  int? totalPrice;
  int? paymentStatus;
  int? orderStatus;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.orderId,
        this.addressId,
        this.userId,
        this.cartItems,
        this.address,
        this.totalPrice,
        this.paymentStatus,
        this.orderStatus,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    addressId = json['address_id'];
    userId = json['user_id'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    totalPrice = json['total_price'];
    paymentStatus = json['payment_status'];
    orderStatus = json['order_status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['address_id'] = this.addressId;
    data['user_id'] = this.userId;
    if (this.cartItems != null) {
      data['cart_items'] = this.cartItems!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    data['total_price'] = this.totalPrice;
    data['payment_status'] = this.paymentStatus;
    data['order_status'] = this.orderStatus;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class CartItems {
  int? id;
  int? userId;
  String? deviceId;
  int? productId;
  int? variationId;
  int? colorId;
  int? brandId;
  int? clothId;
  String? price;
  String? totalPrice;
  int? quantity;
  String? size;
  int? centerStitch;
  String? createdAt;
  String? updatedAt;
  String? productName;
  String? image;
  List<Images>? images;
  String? colorName;
  String? brandName;
  String? clothName;

  CartItems(
      {this.id,
        this.userId,
        this.deviceId,
        this.productId,
        this.variationId,
        this.colorId,
        this.brandId,
        this.clothId,
        this.price,
        this.totalPrice,
        this.quantity,
        this.size,
        this.centerStitch,
        this.createdAt,
        this.updatedAt,
        this.productName,
        this.image,
        this.images,
        this.colorName,
        this.brandName,
        this.clothName});

  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    deviceId = json['device_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    colorId = json['color_id'];
    brandId = json['brand_id'];
    clothId = json['cloth_id'];
    price = json['price'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    size = json['size'];
    centerStitch = json['center_stitch'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
    image = json['image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    colorName = json['color_name'];
    brandName = json['brand_name'];
    clothName = json['cloth_name'];
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
    data['total_price'] = this.totalPrice;
    data['quantity'] = this.quantity;
    data['size'] = this.size;
    data['center_stitch'] = this.centerStitch;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['color_name'] = this.colorName;
    data['brand_name'] = this.brandName;
    data['cloth_name'] = this.clothName;
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

class Address {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? address;
  String? mobile;
  String? pincode;
  String? state;
  String? city;
  String? country;
  String? addressType;
  String? status;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.address,
        this.mobile,
        this.pincode,
        this.state,
        this.city,
        this.country,
        this.addressType,
        this.status,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    mobile = json['mobile'];
    pincode = json['pincode'];
    state = json['state'];
    city = json['city'];
    country = json['country'];
    addressType = json['address_type'];
    status = json['status'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['city'] = this.city;
    data['country'] = this.country;
    data['address_type'] = this.addressType;
    data['status'] = this.status;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}