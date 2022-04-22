// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_feed_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKFeedItem _$VKFeedItemFromJson(Map<String, dynamic> json) => VKFeedItem(
      type: const VKFeedItemTypeConverter().fromJson(json['type'] as String),
      sourceId: json['source_id'] as int?,
      createdBy: json['created_by'] as int?,
      topicId: json['topic_id'] as int?,
      fromId: json['from_id'] as int?,
      id: json['id'] as int?,
      ownerId: json['owner_id'] as int?,
      postId: json['post_id'] as int?,
      signerId: json['signer_id'] as int?,
      date: const NullDateTimeConverter().fromJson(json['date'] as int?),
      accessKey: json['access_key'] as String?,
      text: json['text'] as String?,
      copyHistory: (json['copy_history'] as List<dynamic>?)
          ?.map((e) => VKPost.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : VKWallAttachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      likes: json['likes'] == null
          ? null
          : VKBaseLikes.fromJson(json['likes'] as Map<String, dynamic>),
      views: json['views'] == null
          ? null
          : VKBaseViews.fromJson(json['views'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VKFeedItemToJson(VKFeedItem instance) =>
    <String, dynamic>{
      'source_id': instance.sourceId,
      'created_by': instance.createdBy,
      'topic_id': instance.topicId,
      'from_id': instance.fromId,
      'id': instance.id,
      'owner_id': instance.ownerId,
      'post_id': instance.postId,
      'signer_id': instance.signerId,
      'type': const VKFeedItemTypeConverter().toJson(instance.type),
      'date': const NullDateTimeConverter().toJson(instance.date),
      'access_key': instance.accessKey,
      'text': instance.text,
      'copy_history': instance.copyHistory,
      'attachments': instance.attachments,
      'likes': instance.likes,
      'views': instance.views,
    };
