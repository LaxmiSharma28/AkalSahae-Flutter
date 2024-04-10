class GetOrderApiModal {
  dynamic status;
  dynamic message;
  dynamic statusCode;
  List<Data>? data;

  GetOrderApiModal({this.status, this.message, this.statusCode, this.data});

  GetOrderApiModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic orderId;
  List<CartItems>? cartItems;
  dynamic addressId;
  Address? address;
  dynamic price;
  dynamic discount;
  dynamic totalPrice;
  dynamic quantity;
  dynamic paymentStatus;
  dynamic invoice;
  dynamic orderStatus;
  dynamic deliveryStatus;
  dynamic couponCode;
  dynamic couponDiscount;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic trackingId;
  dynamic trackingUrl;
  dynamic shippingCompanyName;
  dynamic invoicePdf;
  dynamic transactionId;
  dynamic paymentMethod;
  dynamic payMethodId;

  Data(
      {this.id,
      this.userId,
      this.orderId,
      this.cartItems,
      this.addressId,
      this.address,
      this.price,
      this.discount,
      this.totalPrice,
      this.quantity,
      this.paymentStatus,
      this.invoice,
      this.orderStatus,
      this.deliveryStatus,
      this.couponCode,
      this.couponDiscount,
      this.createdAt,
      this.updatedAt,
      this.trackingId,
      this.trackingUrl,
      this.shippingCompanyName,
      this.invoicePdf,
      this.transactionId,
      this.paymentMethod,
      this.payMethodId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    addressId = json['address_id'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    price = json['price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    quantity = json['quantity'];
    paymentStatus = json['payment_status'];
    invoice = json['invoice'];
    orderStatus = json['order_status'];
    deliveryStatus = json['delivery_status'];
    couponCode = json['coupon_code'];
    couponDiscount = json['coupon_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    trackingId = json['tracking_id'];
    trackingUrl = json['tracking_url'];
    shippingCompanyName = json['shipping_company_name'];
    invoicePdf = json['invoice_pdf'];
    transactionId = json['transaction_id'];
    paymentMethod = json['payment_method'];
    payMethodId = json['pay_method_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_id'] = orderId;
    if (cartItems != null) {
      data['cart_items'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['address_id'] = addressId;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['price'] = price;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['quantity'] = quantity;
    data['payment_status'] = paymentStatus;
    data['invoice'] = invoice;
    data['order_status'] = orderStatus;
    data['delivery_status'] = deliveryStatus;
    data['coupon_code'] = couponCode;
    data['coupon_discount'] = couponDiscount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['tracking_id'] = trackingId;
    data['tracking_url'] = trackingUrl;
    data['shipping_company_name'] = shippingCompanyName;
    data['invoice_pdf'] = invoicePdf;
    data['transaction_id'] = transactionId;
    data['payment_method'] = paymentMethod;
    data['pay_method_id'] = payMethodId;
    return data;
  }
}

class CartItems {
  dynamic id;
  dynamic userId;
  dynamic deviceId;
  dynamic productId;
  dynamic variationId;
  dynamic colorId;
  dynamic brandId;
  dynamic clothId;
  dynamic price;
  dynamic totalPrice;
  dynamic gstPercentage;
  dynamic quantity;
  dynamic size;
  dynamic centerStitch;
  dynamic lengthInMeters;
  dynamic stichingPrice;
  dynamic discountOnMrp;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic productName;
  List<Image>? image;
  List<Image>? images;
  dynamic colorName;
  dynamic brandName;
  List<Variations>? variations;
  dynamic productDescription;
  dynamic productVarientDescription;

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
      this.gstPercentage,
      this.quantity,
      this.size,
      this.centerStitch,
      this.lengthInMeters,
      this.stichingPrice,
      this.discountOnMrp,
      this.createdAt,
      this.updatedAt,
      this.productName,
      this.image,
      this.images,
      this.colorName,
      this.brandName,
      this.variations,
      this.productDescription,
      this.productVarientDescription});

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
    gstPercentage = json['gst_percentage'];
    quantity = json['quantity'];
    size = json['size'];
    centerStitch = json['center_stitch'];
    lengthInMeters = json['length_in_meters'];
    stichingPrice = json['stiching_price'];
    discountOnMrp = json['discount_on_mrp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productName = json['product_name'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(Image.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Image>[];
      json['images'].forEach((v) {
        images!.add(Image.fromJson(v));
      });
    }
    colorName = json['color_name'];
    brandName = json['brand_name'];
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(Variations.fromJson(v));
      });
    }
    productDescription = json['product_description'];
    productVarientDescription = json['product_varient_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['device_id'] = deviceId;
    data['product_id'] = productId;
    data['variation_id'] = variationId;
    data['color_id'] = colorId;
    data['brand_id'] = brandId;
    data['cloth_id'] = clothId;
    data['price'] = price;
    data['total_price'] = totalPrice;
    data['gst_percentage'] = gstPercentage;
    data['quantity'] = quantity;
    data['size'] = size;
    data['center_stitch'] = centerStitch;
    data['length_in_meters'] = lengthInMeters;
    data['stiching_price'] = stichingPrice;
    data['discount_on_mrp'] = discountOnMrp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['product_name'] = productName;
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['color_name'] = colorName;
    data['brand_name'] = brandName;
    if (variations != null) {
      data['variations'] = variations!.map((v) => v.toJson()).toList();
    }
    data['product_description'] = productDescription;
    data['product_varient_description'] = productVarientDescription;
    return data;
  }
}

class Image {
  dynamic url;

  Image({this.url});

  Image.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class Variations {
  dynamic key;
  dynamic data;

  Variations({this.key, this.data});

  Variations.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['data'] = this.data;
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic email;
  dynamic address;
  dynamic mobile;
  dynamic pincode;
  dynamic state;
  dynamic city;
  dynamic country;
  dynamic addressType;
  dynamic status;
  dynamic isDefault;
  dynamic createdAt;
  dynamic updatedAt;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['mobile'] = mobile;
    data['pincode'] = pincode;
    data['state'] = state;
    data['city'] = city;
    data['country'] = country;
    data['address_type'] = addressType;
    data['status'] = status;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
