// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKAccessToken _$VKAccessTokenFromJson(Map<String, dynamic> json) =>
    VKAccessToken(
      json['userId'] as String,
      json['token'] as String,
      json['secret'] as String?,
      const NullDateTimeConverter().fromJson(json['created'] as int?),
      json['email'] as String?,
      json['phone'] as String?,
      json['phoneAccessKey'] as String?,
      json['httpsRequired'] == null
          ? true
          : const BooleanConverter().fromJson(json['httpsRequired'] as int?),
      json['expiresIn'] as int? ?? -1,
    );

Map<String, dynamic> _$VKAccessTokenToJson(VKAccessToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'secret': instance.secret,
      'created': const NullDateTimeConverter().toJson(instance.created),
      'email': instance.email,
      'phone': instance.phone,
      'phoneAccessKey': instance.phoneAccessKey,
      'httpsRequired': const BooleanConverter().toJson(instance.httpsRequired),
      'expiresIn': instance.expirationDate,
    };
