// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaResponse _$MetaResponseFromJson(Map<String, dynamic> json) => MetaResponse(
      meta: json['meta'] == null
          ? null
          : MetaResult.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaResponseToJson(MetaResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
    };
