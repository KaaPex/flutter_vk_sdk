// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_user_counters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKUserCounters _$VKUserCountersFromJson(Map<String, dynamic> json) =>
    VKUserCounters(
      json['albums'] as int?,
      json['videos'] as int?,
      json['audios'] as int?,
      json['photos'] as int?,
      json['notes'] as int?,
      json['friends'] as int?,
      json['groups'] as int?,
      json['online_friends'] as int?,
      json['mutual_friends'] as int?,
      json['user_videos'] as int?,
      json['followers'] as int?,
      json['pages'] as int?,
      json['clips_followers'] as int?,
      json['subscriptions'] as int?,
    );

Map<String, dynamic> _$VKUserCountersToJson(VKUserCounters instance) =>
    <String, dynamic>{
      'albums': instance.albums,
      'videos': instance.videos,
      'audios': instance.audios,
      'photos': instance.photos,
      'notes': instance.notes,
      'friends': instance.friends,
      'groups': instance.groups,
      'online_friends': instance.onlineFriends,
      'mutual_friends': instance.mutualFriends,
      'user_videos': instance.userVideos,
      'clips_followers': instance.clipsFollowers,
      'followers': instance.followers,
      'pages': instance.pages,
      'subscriptions': instance.subscriptions,
    };
