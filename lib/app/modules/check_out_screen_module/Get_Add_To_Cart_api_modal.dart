class GetAddToCartApiModal {
  bool? success;
  int? statusCode;
  String? message;
  List<AddData>? data;
  String? totalMrp;
  String? totalDiscountOnMrp;
  String? totalAmount;
  int? addOnPrice;

  GetAddToCartApiModal(
      {this.success,
        this.statusCode,
        this.message,
        this.data,
        this.totalMrp,
        this.totalDiscountOnMrp,
        this.totalAmount,
        this.addOnPrice});

  GetAddToCartApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddData>[];
      json['data'].forEach((v) {
        data!.add(AddData.fromJson(v));
      });
    }
    totalMrp = json['total_mrp'];
    totalDiscountOnMrp = json['total_discount_on_mrp'];
    totalAmount = json['total_amount'];
    addOnPrice = json['add_on_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_mrp'] = this.totalMrp;
    data['total_discount_on_mrp'] = this.totalDiscountOnMrp;
    data['total_amount'] = this.totalAmount;
    data['add_on_price'] = this.addOnPrice;
    return data;
  }
}

class AddData {
  int? cartId;
  Null? deviceId;
  int? productId;
  int? variationId;
  List<Variations>? variations;
  int? colorId;
  String? colorName;
  int? brandId;
  String? brandName;
  String? price;
  String? totalPrice;
  String? size;
  int? quantity;
  String? lengthInMeters;
  int? gstPercentage;
  String? stichingPrice;
  String? productName;
  List<ProductImage>? productImage;
  String? discountOnMrp;

  AddData(
      {this.cartId,
        this.deviceId,
        this.productId,
        this.variationId,
        this.variations,
        this.colorId,
        this.colorName,
        this.brandId,
        this.brandName,
        this.price,
        this.totalPrice,
        this.size,
        this.quantity,
        this.lengthInMeters,
        this.gstPercentage,
        this.stichingPrice,
        this.productName,
        this.productImage,
        this.discountOnMrp});

  AddData.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    deviceId = json['device_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
    colorId = json['color_id'];
    colorName = json['color_name'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    price = json['price'];
    totalPrice = json['total_price'];
    size = json['size'];
    quantity = json['quantity'];
    lengthInMeters = json['length_in_meters'];
    gstPercentage = json['gst_percentage'];
    stichingPrice = json['stiching_price'];
    productName = json['product_name'];
    if (json['product_image'] != null) {
      productImage = <ProductImage>[];
      json['product_image'].forEach((v) {
        productImage!.add(new ProductImage.fromJson(v));
      });
    }
    discountOnMrp = json['discount_on_mrp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['device_id'] = this.deviceId;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    data['color_id'] = this.colorId;
    data['color_name'] = this.colorName;
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    data['length_in_meters'] = this.lengthInMeters;
    data['gst_percentage'] = this.gstPercentage;
    data['stiching_price'] = this.stichingPrice;
    data['product_name'] = this.productName;
    if (this.productImage != null) {
      data['product_image'] =
          this.productImage!.map((v) => v.toJson()).toList();
    }
    data['discount_on_mrp'] = this.discountOnMrp;
    return data;
  }
}

class Variations {
  String? key;
  String? data;

  Variations({this.key, this.data});

  Variations.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['data'] = this.data;
    return data;
  }
}

class ProductImage {
  String? url;

  ProductImage({this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}





/*class GetAddToCartApiModal {
  bool? success;
  int? statusCode;
  String? message;
  List<AddData>? data;
  String? totalMrp;
  String? totalDiscountOnMrp;
  String? totalAmount;

  GetAddToCartApiModal(
      {this.success,
        this.statusCode,
        this.message,
        this.data,
        this.totalMrp,
        this.totalDiscountOnMrp,
        this.totalAmount});

  GetAddToCartApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AddData>[];
      json['data'].forEach((v) {
        data!.add(new AddData.fromJson(v));
      });
    }
    totalMrp = json['total_mrp'];
    totalDiscountOnMrp = json['total_discount_on_mrp'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total_mrp'] = this.totalMrp;
    data['total_discount_on_mrp'] = this.totalDiscountOnMrp;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class AddData {
  int? cartId;
  Null? deviceId;
  int? productId;
  int? variationId;
  List<Variations>? variations;
  int? colorId;
  String? colorName;
  int? brandId;
  String? brandName;
  String? price;
  String? totalPrice;
  String? size;
  int? quantity;
  String? lengthInMeters;
  int? gstPercentage;
  String? stichingPrice;
  String? productName;
  List<ProductImage>? productImage;
  String? discountOnMrp;

  AddData(
      {this.cartId,
        this.deviceId,
        this.productId,
        this.variationId,
        this.variations,
        this.colorId,
        this.colorName,
        this.brandId,
        this.brandName,
        this.price,
        this.totalPrice,
        this.size,
        this.quantity,
        this.lengthInMeters,
        this.gstPercentage,
        this.stichingPrice,
        this.productName,
        this.productImage,
        this.discountOnMrp});

  AddData.fromJson(Map<String, dynamic> json) {
    cartId = json['cart_id'];
    deviceId = json['device_id'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    if (json['variations'] != null) {
      variations = <Variations>[];
      json['variations'].forEach((v) {
        variations!.add(new Variations.fromJson(v));
      });
    }
    colorId = json['color_id'];
    colorName = json['color_name'];
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    price = json['price'];
    totalPrice = json['total_price'];
    size = json['size'];
    quantity = json['quantity'];
    lengthInMeters = json['length_in_meters'];
    gstPercentage = json['gst_percentage'];
    stichingPrice = json['stiching_price'];
    productName = json['product_name'];
    if (json['product_image'] != null) {
      productImage = <ProductImage>[];
      json['product_image'].forEach((v) {
        productImage!.add(new ProductImage.fromJson(v));
      });
    }
    discountOnMrp = json['discount_on_mrp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cart_id'] = this.cartId;
    data['device_id'] = this.deviceId;
    data['product_id'] = this.productId;
    data['variation_id'] = this.variationId;
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    data['color_id'] = this.colorId;
    data['color_name'] = this.colorName;
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['price'] = this.price;
    data['total_price'] = this.totalPrice;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    data['length_in_meters'] = this.lengthInMeters;
    data['gst_percentage'] = this.gstPercentage;
    data['stiching_price'] = this.stichingPrice;
    data['product_name'] = this.productName;
    if (this.productImage != null) {
      data['product_image'] =
          this.productImage!.map((v) => v.toJson()).toList();
    }
    data['discount_on_mrp'] = this.discountOnMrp;
    return data;
  }
}

class Variations {
  String? key;
  String? data;

  Variations({this.key, this.data});

  Variations.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['data'] = this.data;
    return data;
  }
}

class ProductImage {
  String? url;

  ProductImage({this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}*/








