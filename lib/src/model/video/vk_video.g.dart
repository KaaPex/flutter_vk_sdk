// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKVideo _$VKVideoFromJson(Map<String, dynamic> json) => VKVideo(
      json['id'] as int?,
      json['owner_id'] as int?,
      json['user_id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['duration'] as int?,
      (json['image'] as List<dynamic>?)
          ?.map((e) => VKVideoImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['first_frame'] as List<dynamic>?)
          ?.map((e) => VKVideoImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      const NullDateTimeConverter().fromJson(json['date'] as int?),
      const NullDateTimeConverter().fromJson(json['adding_date'] as int?),
      json['views'] as int?,
      json['local_views'] as int?,
      json['comments'] as int?,
      json['player'] as String?,
      json['platform'] as String?,
      const NullBooleanConverter().fromJson(json['can_add'] as int?),
      const NullBooleanConverter().fromJson(json['is_private'] as int?),
      json['access_key'] as String?,
      const NullBooleanConverter().fromJson(json['processing'] as int?),
      json['is_favorite'] as bool? ?? false,
      const NullBooleanConverter().fromJson(json['can_comment'] as int?),
      const NullBooleanConverter().fromJson(json['can_edit'] as int?),
      const NullBooleanConverter().fromJson(json['can_like'] as int?),
      const NullBooleanConverter().fromJson(json['can_repost'] as int?),
      const NullBooleanConverter().fromJson(json['can_subscribe'] as int?),
      const NullBooleanConverter().fromJson(json['can_add_to_faves'] as int?),
      const NullBooleanConverter().fromJson(json['can_attach_link'] as int?),
      json['width'] as int?,
      json['height'] as int?,
      const NullBooleanConverter().fromJson(json['converting'] as int?),
      const NullBooleanConverter().fromJson(json['added'] as int?),
      const NullBooleanConverter().fromJson(json['is_subscribed'] as int?),
      const NullBooleanConverter().fromJson(json['repeat'] as int?),
      $enumDecodeNullable(_$VKVideoTypeEnumMap, json['type']),
      json['track_code'] as String?,
      json['balance'] as int?,
      $enumDecodeNullable(_$VKVideoLiveStatusEnumMap, json['live_status']),
      const NullBooleanConverter().fromJson(json['live'] as int?),
      const NullBooleanConverter().fromJson(json['upcoming'] as int?),
      json['spectators'] as int?,
      json['likes'] == null
          ? null
          : VKBaseLikes.fromJson(json['likes'] as Map<String, dynamic>),
      json['reposts'] == null
          ? null
          : VKVideoRepost.fromJson(json['reposts'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VKVideoToJson(VKVideo instance) => <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'user_id': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration,
      'image': instance.image,
      'first_frame': instance.firstFrame,
      'date': const NullDateTimeConverter().toJson(instance.date),
      'adding_date': const NullDateTimeConverter().toJson(instance.addingDate),
      'views': instance.views,
      'local_views': instance.localViews,
      'comments': instance.comments,
      'player': instance.player,
      'platform': instance.platform,
      'can_add': const NullBooleanConverter().toJson(instance.canAdd),
      'is_private': const NullBooleanConverter().toJson(instance.isPrivate),
      'access_key': instance.accessKey,
      'processing': const NullBooleanConverter().toJson(instance.processing),
      'is_favorite': instance.isFavorite,
      'can_comment': const NullBooleanConverter().toJson(instance.canComment),
      'can_edit': const NullBooleanConverter().toJson(instance.canEdit),
      'can_like': const NullBooleanConverter().toJson(instance.canLike),
      'can_repost': const NullBooleanConverter().toJson(instance.canRepost),
      'can_subscribe':
          const NullBooleanConverter().toJson(instance.canSubscribe),
      'can_add_to_faves':
          const NullBooleanConverter().toJson(instance.canAddToFaves),
      'can_attach_link':
          const NullBooleanConverter().toJson(instance.canAttachLink),
      'width': instance.width,
      'height': instance.height,
      'converting': const NullBooleanConverter().toJson(instance.converting),
      'added': const NullBooleanConverter().toJson(instance.added),
      'is_subscribed':
          const NullBooleanConverter().toJson(instance.isSubscribed),
      'repeat': const NullBooleanConverter().toJson(instance.repeat),
      'type': _$VKVideoTypeEnumMap[instance.type],
      'track_code': instance.trackCode,
      'balance': instance.balance,
      'live_status': _$VKVideoLiveStatusEnumMap[instance.liveStatus],
      'live': const NullBooleanConverter().toJson(instance.live),
      'upcoming': const NullBooleanConverter().toJson(instance.upcoming),
      'spectators': instance.spectators,
      'likes': instance.likes,
      'reposts': instance.reposts,
    };

const _$VKVideoTypeEnumMap = {
  VKVideoType.video: 'video',
  VKVideoType.music_video: 'music_video',
  VKVideoType.movie: 'movie',
};

const _$VKVideoLiveStatusEnumMap = {
  VKVideoLiveStatus.waiting: 'waiting',
  VKVideoLiveStatus.started: 'started',
  VKVideoLiveStatus.finished: 'finished',
  VKVideoLiveStatus.failed: 'failed',
  VKVideoLiveStatus.upcoming: 'upcoming',
};
