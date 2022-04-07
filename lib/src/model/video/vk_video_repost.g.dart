// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_video_repost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKVideoRepost _$VKVideoRepostFromJson(Map<String, dynamic> json) =>
    VKVideoRepost(
      json['count'] as int,
      json['wall_count'] as int?,
      json['mail_count'] as int?,
      const NullBooleanConverter().fromJson(json['user_reposted'] as int?),
    );

Map<String, dynamic> _$VKVideoRepostToJson(VKVideoRepost instance) =>
    <String, dynamic>{
      'count': instance.count,
      'wall_count': instance.wallCount,
      'mail_count': instance.mailCount,
      'user_reposted':
          const NullBooleanConverter().toJson(instance.userReposted),
    };
