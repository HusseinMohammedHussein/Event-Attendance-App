import 'package:json_annotation/json_annotation.dart';

import '../meta_result.dart';
import 'access_token.dart';
import 'token.dart';

part 'login_data.g.dart';

@JsonSerializable()
class LoginData extends MetaResult {
  @JsonKey(name: "access_token")
  AccessToken? accessToken;

  LoginData({this.accessToken});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
