class ForgotPasswordModel {
  String? otp;
  String? userId;

  ForgotPasswordModel({this.otp, this.userId});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['user_id'] = this.userId;
    return data;
  }
}
