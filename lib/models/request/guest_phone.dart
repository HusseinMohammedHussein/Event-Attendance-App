import 'package:json_annotation/json_annotation.dart';

part 'guest_phone.g.dart';

@JsonSerializable()
class GuestPhone {
  @JsonKey(name: "guest_phone")
  String? guestPhone;

  GuestPhone({this.guestPhone});

  factory GuestPhone.fromJson(Map<String, dynamic> json) =>
      _$GuestPhoneFromJson(json);

  Map<String, dynamic> toJson() => _$GuestPhoneToJson(this);
}