import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/constants/constants.dart';

class NullDateTimeConverter implements JsonConverter<DateTime?, int?> {
  const NullDateTimeConverter();

  @override
  DateTime? fromJson(int? json) => json != null ? DateTime.fromMillisecondsSinceEpoch(json) : null;

  @override
  int? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}

class BooleanConverter implements JsonConverter<bool, int?> {
  const BooleanConverter();

  @override
  bool fromJson(int? json) => json == 1 ? true : false;

  @override
  int toJson(bool object) => object == true ? 1 : 0;
}

class NullBooleanConverter implements JsonConverter<bool?, int?> {
  const NullBooleanConverter();

  @override
  bool fromJson(int? json) => json == 1 ? true : false;

  @override
  int toJson(bool? object) => object != null ? 1 : 0;
}

class VKAttachmentTypeConverter implements JsonConverter<VKAttachmentType, String> {
  const VKAttachmentTypeConverter();

  @override
  VKAttachmentType fromJson(String json) => VKAttachmentType.values.asNameMap()[json] ?? VKAttachmentType.photo;

  @override
  String toJson(VKAttachmentType object) => object.name;
}

class VKPhotoSizeTypeConverter implements JsonConverter<VKPhotoSizeType, String> {
  const VKPhotoSizeTypeConverter();

  @override
  VKPhotoSizeType fromJson(String json) => VKPhotoSizeType.values.asNameMap()[json] ?? VKPhotoSizeType.w;

  @override
  String toJson(VKPhotoSizeType object) => object.name;
}

class VKVideoLiveStatusConverter implements JsonConverter<VKVideoLiveStatus, String> {
  const VKVideoLiveStatusConverter();

  @override
  VKVideoLiveStatus fromJson(String json) => VKVideoLiveStatus.values.asNameMap()[json] ?? VKVideoLiveStatus.failed;

  @override
  String toJson(VKVideoLiveStatus object) => object.name;
}

class VKAudioGenreConverter implements JsonConverter<VKAudioGenre, int> {
  const VKAudioGenreConverter();

  @override
  VKAudioGenre fromJson(int json) {
    for (VKAudioGenre value in VKAudioGenre.values) {
      if (value.code == json) {
        return value;
      }
    }
    return VKAudioGenre.Other;
  }

  @override
  int toJson(VKAudioGenre object) => object.code;
}
