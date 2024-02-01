// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promoter_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequest _$RegisterRequestFromJson(Map<String, dynamic> json) =>
    RegisterRequest(
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      address: json['address'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RegisterRequestToJson(RegisterRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'phone': instance.phone,
    };
