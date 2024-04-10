class PinCodeApiModal {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  PinCodeApiModal({this.success, this.statusCode, this.message, this.data});

  PinCodeApiModal.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? json['data'].toString().isNotEmpty? Data.fromJson(json['data']) : null:null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status_code'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? country;
  String? state;
  List<String>? city;

  Data({this.country, this.state, this.city});

  Data.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    return data;
  }
}
