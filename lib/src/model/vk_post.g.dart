// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKPost _$VKPostFromJson(Map<String, dynamic> json) => VKPost(
      json['id'] as int,
      json['owner_id'] as int,
      json['from_id'] as int,
      const DateTimeConverter().fromJson(json['date'] as int),
      json['created_by'] as int?,
      json['text'] as String?,
    );

Map<String, dynamic> _$VKPostToJson(VKPost instance) => <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'from_id': instance.fromId,
      'created_by': instance.createdBy,
      'date': const DateTimeConverter().toJson(instance.date),
      'text': instance.text,
    };
