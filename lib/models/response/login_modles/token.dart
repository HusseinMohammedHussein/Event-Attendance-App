import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: "token")
  String? accessToken;

  Token({this.accessToken});

  factory Token.fromJson(Map<String, dynamic> json) =>
      _$TokenFromJson(json);

  Map<String, dynamic> toJson() => _$TokenToJson(this);
}
