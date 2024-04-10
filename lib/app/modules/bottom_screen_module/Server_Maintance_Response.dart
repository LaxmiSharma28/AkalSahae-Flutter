class ServerMaintenanceResponse {
  dynamic title;
  dynamic message;
  dynamic status;

  ServerMaintenanceResponse({this.title, this.message, this.status});

  ServerMaintenanceResponse.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
