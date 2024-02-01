import 'package:json_annotation/json_annotation.dart';

import 'meta_result.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  @JsonKey(name: "meta")
  MetaResult? meta;

  MetaResponse({this.meta});

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);
}
