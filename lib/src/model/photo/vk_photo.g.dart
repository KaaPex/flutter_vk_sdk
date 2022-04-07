// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKPhoto _$VKPhotoFromJson(Map<String, dynamic> json) => VKPhoto(
      json['id'] as int,
      json['album_id'] as int,
      json['owner_id'] as int,
      json['user_id'] as int?,
      json['has_tags'] as bool?,
      json['text'] as String?,
      const NullDateTimeConverter().fromJson(json['date'] as int?),
      (json['sizes'] as List<dynamic>?)
          ?.map((e) => VKPhotoSize.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['width'] as int?,
      json['height'] as int?,
    );

Map<String, dynamic> _$VKPhotoToJson(VKPhoto instance) => <String, dynamic>{
      'id': instance.id,
      'album_id': instance.albumId,
      'owner_id': instance.ownerId,
      'user_id': instance.userId,
      'has_tags': instance.hasTags,
      'text': instance.text,
      'date': const NullDateTimeConverter().toJson(instance.date),
      'sizes': instance.sizes,
      'width': instance.width,
      'height': instance.height,
    };
