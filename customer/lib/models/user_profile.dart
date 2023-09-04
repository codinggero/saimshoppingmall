class UserProfile {
  String? status;
  String? message;
  String? total;
  Data? data;

  UserProfile({this.status, this.message, this.total, this.data});

  UserProfile.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    total = json['total'].toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['total'] = total;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;
  String? accessToken;

  Data({this.user, this.accessToken});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    accessToken = json['access_token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['access_token'] = accessToken;
    return data;
  }
}

class User {
  String? id;
  String? name;
  String? email;
  String? countryCode;
  String? mobile;
  String? profile;
  String? balance;
  String? referralCode;
  String? status;

  User(
      {this.id,
      this.name,
      this.email,
      this.countryCode,
      this.mobile,
      this.profile,
      this.balance,
      this.referralCode,
      this.status});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    countryCode = json['country_code'].toString();
    mobile = json['mobile'].toString();
    profile = json['profile'].toString();
    balance = json['balance'].toString();
    referralCode = json['referral_code'].toString();
    status = json['status'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['profile'] = profile;
    data['balance'] = balance;
    data['referral_code'] = referralCode;
    data['status'] = status;
    return data;
  }
}
