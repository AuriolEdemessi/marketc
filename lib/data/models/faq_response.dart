import 'package:equatable/equatable.dart';

import '../../export.dart';

class FaqResponse extends Equatable {

  final List<FaqModel> faqList;

  const FaqResponse({required this.faqList});

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(faqList: List<FaqModel>.from((json['data']['faq'] as List).map((x) => FaqModel.fromJson(x))),);

  Map<String, dynamic> toJson() => {'faq': List<dynamic>.from(faqList.map((x) => x.toJson())),};

  @override
  List<Object> get props => [faqList];
}