import 'package:json_annotation/json_annotation.dart';

import '../meta.dart';
import 'login_access_token.dart';

part 'login_data.g.dart';

@JsonSerializable()
class LoginData {
  @JsonKey(name: "access_token")
  AccessToken? accessToken;


  LoginData({this.accessToken});

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}