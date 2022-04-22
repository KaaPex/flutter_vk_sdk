// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKFeed _$VKFeedFromJson(Map<String, dynamic> json) => VKFeed(
      nextFrom: json['next_from'] as int,
      newOffset: json['new_offset'] as int,
      items: (json['items'] as List<dynamic>)
          .map((e) => VKFeedItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      profiles: (json['profiles'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : VKUserProfile.fromJson(e as Map<String, dynamic>))
          .toList(),
      groups: (json['groups'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : VKGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VKFeedToJson(VKFeed instance) => <String, dynamic>{
      'next_from': instance.nextFrom,
      'new_offset': instance.newOffset,
      'items': instance.items,
      'profiles': instance.profiles,
      'groups': instance.groups,
    };
