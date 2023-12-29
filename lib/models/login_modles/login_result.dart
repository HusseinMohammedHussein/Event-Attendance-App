import 'package:json_annotation/json_annotation.dart';

import '../meta.dart';
import 'login_data.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult {
  @JsonKey(name: "meta")
  MetaResult? meta;
  @JsonKey(name: "data")
  LoginData? data;


  LoginResult({this.meta, this.data});

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}