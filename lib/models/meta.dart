import 'package:json_annotation/json_annotation.dart';

part 'meta.g.dart';

@JsonSerializable()
class MetaResult {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;


  MetaResult({this.code, this.status, this.message});

  factory MetaResult.fromJson(Map<String, dynamic> json) => _$MetaResultFromJson(json);
  Map<String, dynamic> toJson() => _$MetaResultToJson(this);
}