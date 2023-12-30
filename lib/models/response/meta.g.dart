// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaResponse _$MetaDataFromJson(Map<String, dynamic> json) => MetaResponse(
      meta: json['meta'] == null
          ? null
          : MetaResult.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MetaDataToJson(MetaResponse instance) => <String, dynamic>{
      'meta': instance.meta,
    };
