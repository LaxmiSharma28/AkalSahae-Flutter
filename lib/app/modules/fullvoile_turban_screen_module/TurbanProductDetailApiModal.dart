class TurbanProductDetailApiModal {
  dynamic success;
  dynamic statusCode;
  TurbanData? data;

  TurbanProductDetailApiModal({this.success, this.statusCode, this.data});

  TurbanProductDetailApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    data = json['data'] != null ? TurbanData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class TurbanData {
  dynamic id;
  dynamic productName;
  dynamic attributes;
  dynamic image;
  List<Images>? images;
  dynamic price;
  dynamic gstPercentage;
  dynamic discountOnMrp;
  dynamic status;
  dynamic hasVariation;
  dynamic lengthAvailable;
  dynamic endingLength;
  dynamic startingLength;
  dynamic stichingAvailable;
  dynamic stichingPrice;
  dynamic description;
  dynamic weight;
  dynamic quantity;
  ProductVariations? productVariations;
  dynamic isFavorite;
  List<Length>? length;

  TurbanData(
      {this.id,
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
      this.length});

  TurbanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    attributes = json['attributes'];
    image = json['image'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    price = json['price'];
    gstPercentage = json['gst_percentage'];
    discountOnMrp = json['discount_on_mrp'];
    status = json['status'];
    hasVariation = json['has_variation'];
    lengthAvailable = json['length_available'];
    endingLength = json['ending_length'];
    startingLength = json['starting_length'];
    stichingAvailable = json['stiching_available'];
    stichingPrice = json['stiching_price'];
    description = json['description'];
    weight = json['weight'];
    quantity = json['quantity'];
    productVariations = json['product_variations'] != null
        ? ProductVariations.fromJson(json['product_variations'])
        : null;
    isFavorite = json['is_favorite'];
    if (json['length'] != null) {
      length = <Length>[];
      json['length'].forEach((v) {
        length!.add(Length.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['attributes'] = attributes;
    data['image'] = image;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['price'] = price;
    data['gst_percentage'] = gstPercentage;
    data['discount_on_mrp'] = discountOnMrp;
    data['status'] = status;
    data['has_variation'] = hasVariation;
    data['length_available'] = lengthAvailable;
    data['ending_length'] = endingLength;
    data['starting_length'] = startingLength;
    data['stiching_available'] = stichingAvailable;
    data['stiching_price'] = stichingPrice;
    data['description'] = description;
    data['weight'] = weight;
    data['quantity'] = quantity;
    if (productVariations != null) {
      data['product_variations'] = productVariations!.toJson();
    }
    data['is_favorite'] = isFavorite;
    if (length != null) {
      data['length'] = length!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  dynamic url;

  Images({this.url});

  Images.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class ProductVariations {
  dynamic key;
  List<BrandData>? data;

  ProductVariations({this.key, this.data});

  ProductVariations.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    if (json['data'] != null) {
      data = <BrandData>[];
      json['data'].forEach((v) {
        data!.add(BrandData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BrandData {
  dynamic id;
  dynamic productId;
  dynamic colorId;
  dynamic brandId;
  dynamic brandPrice;
  dynamic brandName;
  List<Images>? images;
  dynamic attributeId;
  dynamic attributeName;
  dynamic attributeValue;
  dynamic price;
  dynamic gstPercentage;
  dynamic quantity;
  dynamic weight;
  dynamic discountOnMrp;
  dynamic description;
  dynamic outOfStock;

  BrandData(
      {this.id,
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
      this.outOfStock});

  BrandData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    colorId = json['color_id'];
    brandId = json['brand_id'];
    brandPrice = json['brand_price'];
    brandName = json['brand_name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    attributeId = json['attribute_id'];
    attributeName = json['attribute_name'];
    attributeValue = json['attribute_value'];
    price = json['price'];
    gstPercentage = json['gst_percentage'];
    quantity = json['quantity'];
    weight = json['weight'];
    discountOnMrp = json['discount_on_mrp'];
    description = json['description'];
    outOfStock=json['out_of_stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['color_id'] = colorId;
    data['brand_id'] = brandId;
    data['brand_price'] = brandPrice;
    data['brand_name'] = brandName;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    data['attribute_id'] = attributeId;
    data['attribute_name'] = attributeName;
    data['attribute_value'] = attributeValue;
    data['price'] = price;
    data['gst_percentage'] = gstPercentage;
    data['quantity'] = quantity;
    data['weight'] = weight;
    data['discount_on_mrp'] = discountOnMrp;
    data['description'] = description;
    data['out_of_stock'] = outOfStock;
    return data;
  }
}

class Length {
  dynamic key;

  Length({this.key});

  Length.fromJson(Map<String, dynamic> json) {
    key = json['Key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Key'] = key;
    return data;
  }
}