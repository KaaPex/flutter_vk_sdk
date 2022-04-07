// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_video_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKVideoImage _$VKVideoImageFromJson(Map<String, dynamic> json) => VKVideoImage(
      json['height'] as int,
      json['url'] as String,
      json['width'] as int,
      json['with_padding'] as int?,
    );

Map<String, dynamic> _$VKVideoImageToJson(VKVideoImage instance) =>
    <String, dynamic>{
      'height': instance.height,
      'url': instance.url,
      'width': instance.width,
      'with_padding': instance.withPadding,
    };
