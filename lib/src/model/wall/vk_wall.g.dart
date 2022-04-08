// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_wall.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKWall _$VKWallFromJson(Map<String, dynamic> json) => VKWall(
      json['count'] as int,
      (json['items'] as List<dynamic>)
          .map((e) => VKPost.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['profiles'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : VKUserProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['groups'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : VKGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VKWallToJson(VKWall instance) => <String, dynamic>{
      'count': instance.count,
      'items': instance.items,
      'profiles': instance.profiles,
      'groups': instance.groups,
    };
