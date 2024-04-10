class LoginRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? countryCode;
  String? fcmToken;
  String? deviceId;
  String? deviceType;
  String? buildNo;
  String? buildVersion;
  String? deviceModel;
  String? deviceName;
  String? osVersion;
  String? accountStatus;
  String? newAccount;
  String? basicInfo;
  String? createdAt;
  String? updatedAt;
  String? token;

  LoginRequest(
      {this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.countryCode,
        this.fcmToken,
        this.deviceId,
        this.deviceType,
        this.buildNo,
        this.buildVersion,
        this.deviceModel,
        this.deviceName,
        this.osVersion,
        this.accountStatus,
        this.newAccount,
        this.basicInfo,
        this.createdAt,
        this.updatedAt,
        this.token});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    fcmToken = json['fcm_token'];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    buildNo = json['build_no'];
    buildVersion = json['build_version'];
    deviceModel = json['device_model'];
    deviceName = json['device_name'];
    osVersion = json['os_version'];
    accountStatus = json['account_status'];
    newAccount = json['new_account'];
    basicInfo = json['basic_info'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country_code'] = this.countryCode;
    data['fcm_token'] = this.fcmToken;
    data['device_id'] = this.deviceId;
    data['device_type'] = this.deviceType;
    data['build_no'] = this.buildNo;
    data['build_version'] = this.buildVersion;
    data['device_model'] = this.deviceModel;
    data['device_name'] = this.deviceName;
    data['os_version'] = this.osVersion;
    data['account_status'] = this.accountStatus;
    data['new_account'] = this.newAccount;
    data['basic_info'] = this.basicInfo;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    return data;
  }
}
