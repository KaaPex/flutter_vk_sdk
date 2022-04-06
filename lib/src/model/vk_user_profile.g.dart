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
      json['nickname'] as String? ?? '',
      json['domain'] as String?,
      json['screen_name'] as String?,
      json['status'] as String?,
      json['status_audio'] as String?,
      json['online'] == null
          ? false
          : const BooleanConverter().fromJson(json['online'] as int),
      json['online_mobile'] == null
          ? false
          : const BooleanConverter().fromJson(json['online_mobile'] as int),
      json['photo_50'] as String?,
      json['photo_100'] as String?,
      json['photo_200'] as String?,
      json['is_closed'] as bool? ?? false,
      json['can_access_closed'] as bool? ?? false,
      json['counters'] == null
          ? null
          : VKUserCounters.fromJson(json['counters'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VKUserProfileToJson(VKUserProfile instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'nickname': instance.nickname,
      'domain': instance.domain,
      'screen_name': instance.screenName,
      'online': const BooleanConverter().toJson(instance.online),
      'status': instance.status,
      'status_audio': instance.statusAudio,
      'online_mobile': const BooleanConverter().toJson(instance.onlineMobile),
      'photo_50': instance.photo50,
      'photo_100': instance.photo100,
      'photo_200': instance.photo200,
      'is_closed': instance.isClosed,
      'can_access_closed': instance.canAccessClosed,
      'counters': instance.counters,
    };
