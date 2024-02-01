import 'package:json_annotation/json_annotation.dart';

part 'promoter_phone.g.dart';

@JsonSerializable()
class PromoterPhone {
  @JsonKey(name: "phone")
  String? phone;

  PromoterPhone({this.phone});

  factory PromoterPhone.fromJson(Map<String, dynamic> json) =>
      _$PromoterPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$PromoterPhoneToJson(this);
}
