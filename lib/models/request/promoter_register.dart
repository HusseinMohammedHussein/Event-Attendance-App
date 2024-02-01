import 'package:json_annotation/json_annotation.dart';

part 'promoter_register.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "phone")
  String? phone;

  RegisterRequest(
      {this.phone, this.password, this.address, this.email, this.name});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}
