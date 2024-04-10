class AddAddressApiModal {
  bool? success;
  int? statusCode;
  String? message;
  Address? address;

  AddAddressApiModal(
      {this.success, this.statusCode, this.message, this.address});

  AddAddressApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
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
  String? shippingName;
  String? shippingEmail;
  String? shippingAddress;
  String? shippingMobile;
  String? shippingPincode;
  String? shippingState;
  String? shippingCity;
  String? shippingCountry;
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
        this.shippingName,
        this.shippingEmail,
        this.shippingAddress,
        this.shippingMobile,
        this.shippingPincode,
        this.shippingState,
        this.shippingCity,
        this.shippingCountry,
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
    shippingName = json['shipping_name'];
    shippingEmail = json['shipping_email'];
    shippingAddress = json['shipping_address'];
    shippingMobile = json['shipping_mobile'];
    shippingPincode = json['shipping_pincode'];
    shippingState = json['shipping_state'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
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
    data['shipping_name'] = this.shippingName;
    data['shipping_email'] = this.shippingEmail;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_mobile'] = this.shippingMobile;
    data['shipping_pincode'] = this.shippingPincode;
    data['shipping_state'] = this.shippingState;
    data['shipping_city'] = this.shippingCity;
    data['shipping_country'] = this.shippingCountry;
    data['address_type'] = this.addressType;
    data['status'] = this.status;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


/*
class AddAddressApiModal {
  bool? success;
  int? statusCode;
  String? message;
  Address? address;

  AddAddressApiModal(
      {this.success, this.statusCode, this.message, this.address});

  AddAddressApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
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

*/
