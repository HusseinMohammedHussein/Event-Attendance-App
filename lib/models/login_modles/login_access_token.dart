import 'package:json_annotation/json_annotation.dart';

import '../meta.dart';

part 'login_access_token.g.dart';

@JsonSerializable()
class AccessToken {
  @JsonKey(name: "token")
  String? accessToken;


  AccessToken({this.accessToken});

  factory AccessToken.fromJson(Map<String, dynamic> json) => _$AccessTokenFromJson(json);
  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}