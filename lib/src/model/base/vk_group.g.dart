// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKGroup _$VKGroupFromJson(Map<String, dynamic> json) => VKGroup(
      json['id'] as int,
      json['name'] as String,
      json['screen_name'] as String?,
      json['photo_50'] as String?,
    );

Map<String, dynamic> _$VKGroupToJson(VKGroup instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'screen_name': instance.screenName,
      'photo_50': instance.photo50,
    };
