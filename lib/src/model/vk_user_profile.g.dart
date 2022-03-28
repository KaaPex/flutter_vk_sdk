// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKUserProfile _$VKUserProfileFromJson(Map<String, dynamic> json) =>
    VKUserProfile(
      json['id'] as int,
      json['first_name'] as String,
      json['last_name'] as String,
      json['online'] == null
          ? false
          : const BooleanConverter().fromJson(json['online'] as int),
      json['online_mobile'] == null
          ? false
          : const BooleanConverter().fromJson(json['online_mobile'] as int),
      json['photo_50'] as String?,
      json['photo_100'] as String?,
      json['photo_200'] as String?,
    );

Map<String, dynamic> _$VKUserProfileToJson(VKUserProfile instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'online': const BooleanConverter().toJson(instance.online),
      'online_mobile': const BooleanConverter().toJson(instance.onlineMobile),
      'photo_50': instance.photo50,
      'photo_100': instance.photo100,
      'photo_200': instance.photo200,
    };
