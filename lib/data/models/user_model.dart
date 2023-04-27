import 'wallet_user.dart';

class UserModel {
  String? fname;
  String? lname;
  String? username;
  String? email;
  String? phoneIndicatif;
  String? phone;
  String? image;
  int? phoneVerify;
  int? emailVerify;
  String? emailTime;
  String? phoneTime;
  int? refer;
  int? level;
  String? reference;
  String? deviceId;
  String? balance;
  String? bonus;
  int? status;
  int? userId;
  int? verified;
  String? dob;
  String? gender;
  String? loginTime;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? country;
  String? provider;
  String? providerId;
  String? time;
  String? timezone;
  List<WalletUser>? wallet;

  UserModel(
      {this.fname,
        this.lname,
        this.username,
        this.email,
        this.phoneIndicatif,
        this.userId,
        this.phone,
        this.image,
        this.phoneVerify,
        this.deviceId,
        this.emailVerify,
        this.emailTime,
        this.phoneTime,
        this.refer,
        this.level,
        this.reference,
        this.balance,
        this.bonus,
        this.status,
        this.verified,
        this.dob,
        this.gender,
        this.loginTime,
        this.address,
        this.city,
        this.state,
        this.zipCode,
        this.country,
        this.provider,
        this.providerId,
        this.time,
        this.timezone,
        this.wallet});

  UserModel.fromJson(Map<String, dynamic> json) {
    fname = json['fname'];
    lname = json['lname'];
    username = json['username'];
    deviceId = json['device_id'];
    email = json['email'];
    userId = json['user_id'];
    phoneIndicatif = json['phone_indicatif'];
    phone = json['phone'];
    image = json['image'];
    phoneVerify = json['phone_verify'];
    emailVerify = json['email_verify'];
    emailTime = json['email_time'];
    phoneTime = json['phone_time'];
    refer = json['refer'];
    level = json['level'];
    reference = json['reference'];
    balance = json['balance'];
    bonus = json['bonus'];
    status = json['status'];
    verified = json['verified'];
    dob = json['dob'];
    gender = json['gender'];
    loginTime = json['login_time'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    country = json['country'];
    provider = json['provider'];
    providerId = json['provider_id'];
    time = json['time'];
    timezone = json['timezone'];
    if (json['wallet'] != null) {
      wallet = <WalletUser>[];
      json['wallet'].forEach((v) {
        wallet!.add(new WalletUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['user_id'] = this.userId;
    data['device_id'] = this.deviceId;
    data['phone_indicatif'] = this.phoneIndicatif;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['phone_verify'] = this.phoneVerify;
    data['email_verify'] = this.emailVerify;
    data['email_time'] = this.emailTime;
    data['phone_time'] = this.phoneTime;
    data['refer'] = this.refer;
    data['level'] = this.level;
    data['reference'] = this.reference;
    data['balance'] = this.balance;
    data['bonus'] = this.bonus;
    data['status'] = this.status;
    data['verified'] = this.verified;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['login_time'] = this.loginTime;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['provider'] = this.provider;
    data['provider_id'] = this.providerId;
    data['time'] = this.time;
    data['timezone'] = this.timezone;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}