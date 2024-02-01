// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      accessToken: json['access_token'] == null
          ? null
          : AccessToken.fromJson(json['access_token'] as Map<String, dynamic>),
    )
      ..code = json['code'] as int?
      ..status = json['status'] as String?
      ..message = json['message'] as String?;

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'access_token': instance.accessToken,
    };
