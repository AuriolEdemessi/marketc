import 'package:equatable/equatable.dart';

class User extends Equatable{
  int? id;
  String? fname;
  String? lname;
  String? username;
  String? email;
  String? phone;
  String? image;
  String? verificationCode;
  String? smsCode;
  int? phoneVerify;
  int? emailVerify;
  String? emailTime;
  String? phoneTime;
  int? refer;
  int? level;
  String? reference;
  String? balance;
  String? bonus;
  String? bank;
  String? accountno;
  String? accountname;
  int? bankyes;
  String? paypal;
  String? btcwallet;
  int? status;
  String? verified;
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
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? time;
  String? timezone;

  User(
      {
        this.id,
        this.fname,
        this.lname,
        this.username,
        this.email,
        this.phone,
        this.image,
        this.verificationCode,
        this.smsCode,
        this.phoneVerify,
        this.emailVerify,
        this.emailTime,
        this.phoneTime,
        this.refer,
        this.level,
        this.reference,
        this.balance,
        this.bonus,
        this.bank,
        this.accountno,
        this.accountname,
        this.bankyes,
        this.paypal,
        this.btcwallet,
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
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.time,
        this.timezone
      });

  @override
  List<Object?> get props => [
    id,
    fname,
    lname,
    username,
    email,
    phone,
    image,
    verificationCode,
    smsCode,
    phoneVerify,
    emailVerify,
    emailTime,
    phoneTime,
    refer,
    level,
    reference,
    balance,
    bonus,
    bank,
    accountno,
    accountname,
    bankyes,
    paypal,
    btcwallet,
    status,
    verified,
    dob,
    gender,
    loginTime,
    address,
    city,
    state,
    zipCode,
    country,
    provider,
    providerId,
    deletedAt,
    createdAt,
    updatedAt,
    time,
    timezone
  ];

}