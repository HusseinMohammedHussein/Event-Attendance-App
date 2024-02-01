// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessToken _$AccessTokenFromJson(Map<String, dynamic> json) => AccessToken(
      accessToken: json['access_token'] == null
          ? null
          : Token.fromJson(json['access_token'] as Map<String, dynamic>),
    )..meta = json['meta'] == null
        ? null
        : MetaResult.fromJson(json['meta'] as Map<String, dynamic>);

Map<String, dynamic> _$AccessTokenToJson(AccessToken instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'access_token': instance.accessToken,
    };
