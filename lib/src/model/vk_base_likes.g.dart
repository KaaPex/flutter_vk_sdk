// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_base_likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKBaseLikes _$VKBaseLikesFromJson(Map<String, dynamic> json) => VKBaseLikes(
      json['count'] as int?,
      const NullBooleanConverter().fromJson(json['user_likes'] as int?),
    );

Map<String, dynamic> _$VKBaseLikesToJson(VKBaseLikes instance) =>
    <String, dynamic>{
      'count': instance.count,
      'user_likes': const NullBooleanConverter().toJson(instance.userLikes),
    };
