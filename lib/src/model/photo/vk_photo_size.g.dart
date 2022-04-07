// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_photo_size.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKPhotoSize _$VKPhotoSizeFromJson(Map<String, dynamic> json) => VKPhotoSize(
      json['height'] as int,
      json['url'] as String,
      json['width'] as int,
      const VKPhotoSizeTypeConverter().fromJson(json['type'] as String),
    );

Map<String, dynamic> _$VKPhotoSizeToJson(VKPhotoSize instance) =>
    <String, dynamic>{
      'height': instance.height,
      'url': instance.url,
      'type': const VKPhotoSizeTypeConverter().toJson(instance.type),
      'width': instance.width,
    };
