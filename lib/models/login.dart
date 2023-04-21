class Login {
  String? firstName;
  String? lastName;
  String? countryCode;
  String? phoneNumber;
  String? email;
  String? password;
  String? otp;
  int? type;
  String? deviceToken;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? token;
  String? image;
  String? id;

  Login(
      {this.firstName,
      this.lastName,
      this.countryCode,
      this.phoneNumber,
      this.email,
      this.password,
      this.otp,
      this.type,
      this.deviceToken,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.token,
      this.image,
      this.id});

  Login.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    type = json['type'];
    deviceToken = json['device_token'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['type'] = this.type;
    data['device_token'] = this.deviceToken;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['token'] = this.token;
    data['image'] = this.image;
    data['id'] = this.id;
    return data;
  }
}
