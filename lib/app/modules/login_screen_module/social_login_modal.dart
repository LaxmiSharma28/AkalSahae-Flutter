class SocialRequest {
  String? socialId;
  String? socialLoginType;
  String? deviceId;
  String? email;
  String? fcmToken;
  String? deviceType;
  String? buildNo;
  String? buildVersion;
  String? osVersion;
  String? deviceModel;
  String? deviceName;

  SocialRequest(
      {this.socialId,
        this.socialLoginType,
        this.deviceId,
        this.email,
        this.fcmToken,
        this.deviceType,
        this.buildNo,
        this.buildVersion,
        this.osVersion,
        this.deviceModel,
        this.deviceName});

  SocialRequest.fromJson(Map<String, dynamic> json) {
    socialId = json['social_id'];
    socialLoginType = json['Social_login_type'];
    deviceId = json['device_id'];
    email = json['email'];
    fcmToken = json['fcm_token'];
    deviceType = json['device_type'];
    buildNo = json['build_no'];
    buildVersion = json['build_version'];
    osVersion = json['os_version'];
    deviceModel = json['device_model'];
    deviceName = json['device_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['social_id'] = this.socialId;
    data['Social_login_type'] = this.socialLoginType;
    data['device_id'] = this.deviceId;
    data['email'] = this.email;
    data['fcm_token'] = this.fcmToken;
    data['device_type'] = this.deviceType;
    data['build_no'] = this.buildNo;
    data['build_version'] = this.buildVersion;
    data['os_version'] = this.osVersion;
    data['device_model'] = this.deviceModel;
    data['device_name'] = this.deviceName;
    return data;
  }
}
