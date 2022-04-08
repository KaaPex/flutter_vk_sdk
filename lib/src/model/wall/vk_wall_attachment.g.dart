// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_wall_attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKWallAttachment _$VKWallAttachmentFromJson(Map<String, dynamic> json) =>
    VKWallAttachment(
      const VKAttachmentTypeConverter().fromJson(json['type'] as String),
      json['access_key'] as String?,
      json['audio'] == null
          ? null
          : VKAudio.fromJson(json['audio'] as Map<String, dynamic>),
      json['photo'] == null
          ? null
          : VKPhoto.fromJson(json['photo'] as Map<String, dynamic>),
      json['video'] == null
          ? null
          : VKVideo.fromJson(json['video'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VKWallAttachmentToJson(VKWallAttachment instance) =>
    <String, dynamic>{
      'type': const VKAttachmentTypeConverter().toJson(instance.type),
      'access_key': instance.accessKey,
      'audio': instance.audio,
      'photo': instance.photo,
      'video': instance.video,
    };
