// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MetaResult _$MetaResultFromJson(Map<String, dynamic> json) => MetaResult(
      code: json['code'] as int?,
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MetaResultToJson(MetaResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
    };
