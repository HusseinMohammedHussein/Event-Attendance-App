import 'package:business_umbrella/models/response/meta_response.dart';
import 'package:business_umbrella/models/response/meta_result.dart';
import 'package:json_annotation/json_annotation.dart';

import 'token.dart';

part 'access_token.g.dart';

@JsonSerializable()
class AccessToken extends MetaResponse {
  @JsonKey(name: "access_token")
  Token? accessToken;

  AccessToken({this.accessToken});

  factory AccessToken.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenToJson(this);
}
