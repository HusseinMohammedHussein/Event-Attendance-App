import 'package:json_annotation/json_annotation.dart';

import '../meta_result.dart';
import 'login_data.dart';

part 'login_result.g.dart';

@JsonSerializable()
class LoginResult extends MetaResult {
  @JsonKey(name: "data")
  LoginData? data;

  LoginResult({this.data});

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
