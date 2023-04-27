import 'package:equatable/equatable.dart';


class AnnonceModel extends Equatable{
 final int? id;
 final int? userId;
 final String? taux;
 final String? giveId;
 final String? getId;
 final String? qgive;
 final String? qget;
 final String? reserve;
 final String? mMin;
 final String? mMax;
 final String? createdAt;
 final String? updatedAt;
 final String? trId;
 final String? adresseNum;
 final int? status;
 final String? etat;
 final String? giveSymbol;
 final String? getSymbol;
 final String? fname;
 final String? lname;
 final String? username;

  AnnonceModel(
      {
        required this.id,
        required this.userId,
        required this.taux,
        required this.giveId,
        required this.getId,
        required this.qgive,
        required this.qget,
        required this.reserve,
        required this.mMin,
        required this.mMax,
        required this.createdAt,
        required this.updatedAt,
        required this.trId,
        required this.adresseNum,
        required this.status,
        required this.etat,
        required this.giveSymbol,
        required this.getSymbol,
        required this.fname,
        required this.lname,
        required this.username});

  factory AnnonceModel.fromJson(Map<String, dynamic> json)=> AnnonceModel(
    id : json['id'],
    userId : json['user_id'],
    taux : json['taux'],
    giveId : json['give_id'],
    getId : json['get_id'],
    qgive : json['qgive'],
    qget : json['qget'],
    reserve : json['reserve'],
    mMin : json['m_min'],
    mMax : json['m_max'],
    createdAt : json['created_at'],
    updatedAt : json['updated_at'],
    trId : json['tr_id'],
    adresseNum : json['adresse_num'],
    status : json['status'],
    etat : json['etat'],
    giveSymbol : json['give_symbol'],
    getSymbol : json['get_symbol'],
    fname : json['fname'],
    lname : json['lname'],
    username : json['username'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'taux': taux,
    'get_id': giveId,
    'qgive': getId,
    'reserve': reserve,
    'm_min': mMin,
    'm_max': mMax,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'tr_id': trId,
    'adresse_num': adresseNum,
    'status': status,
    'etat': etat,
    'give_symbol': giveSymbol,
    'get_symbol': getSymbol,
    'fname': fname,
    'lname': lname,
    'username': username,
  };

  @override
  List<Object?> get props => [
    id,
    userId,
    taux,
    giveId,
    getId,
    qgive,
    qget,
    reserve,
    mMin,
    mMax,
    createdAt,
    updatedAt,
    trId,
    adresseNum,
    status,
    etat,
    giveSymbol,
    getSymbol,
    fname,
    lname,
    username,
  ];

}