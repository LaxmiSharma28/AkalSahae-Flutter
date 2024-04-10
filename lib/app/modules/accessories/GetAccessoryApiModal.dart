class GetAccessoryApiModal {
  bool? success;
  int? statusCode;
  List<AccessoryData>? data;
  Pagination? pagination;

  GetAccessoryApiModal(
      {this.success, this.statusCode, this.data, this.pagination});

  GetAccessoryApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <AccessoryData>[];
      json['data'].forEach((v) {
        data!.add(new AccessoryData.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status_code'] = this.statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class AccessoryData {
  int? id;
  String? productName;
  String? image;
  String? status;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  AccessoryData(
      {this.id,
        this.productName,
        this.image,
        this.status,
        this.categoryId,
        this.createdAt,
        this.updatedAt});

  AccessoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    image = json['image'];
    status = json['status'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['image'] = this.image;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Pagination {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Pagination({this.currentPage, this.lastPage, this.perPage, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['total'] = this.total;
    return data;
  }
}