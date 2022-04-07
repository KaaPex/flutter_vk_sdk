// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vk_login_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VKLoginResult _$VKLoginResultFromJson(Map<String, dynamic> json) =>
    VKLoginResult(
      json['accessToken'] == null
          ? null
          : VKAccessToken.fromJson(json['accessToken'] as Map<String, dynamic>),
      isCanceled: const BooleanConverter().fromJson(json['isCanceled'] as int?),
    );

Map<String, dynamic> _$VKLoginResultToJson(VKLoginResult instance) =>
    <String, dynamic>{
      'isCanceled': const BooleanConverter().toJson(instance.isCanceled),
      'accessToken': instance.accessToken,
    };
