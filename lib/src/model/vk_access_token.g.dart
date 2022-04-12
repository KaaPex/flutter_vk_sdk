// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_access_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKAccessToken _$VKAccessTokenFromJson(Map<String, dynamic> json) =>
    VKAccessToken(
      json['userId'] as String,
      json['token'] as String,
      const BooleanConverter().fromJson(json['isValid'] as int?),
      const NullDateTimeConverter().fromJson(json['created'] as int?),
      json['email'] as String?,
      json['secret'] as String?,
      json['phone'] as String?,
      json['phoneAccessKey'] as String?,
    );

Map<String, dynamic> _$VKAccessTokenToJson(VKAccessToken instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'created': const NullDateTimeConverter().toJson(instance.created),
      'email': instance.email,
      'isValid': const BooleanConverter().toJson(instance.isValid),
      'secret': instance.secret,
      'phone': instance.phone,
      'phoneAccessKey': instance.phoneAccessKey,
    };
