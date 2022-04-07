import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converter.dart';
import 'vk_photo_size.dart';

part 'vk_photo.g.dart';

@JsonSerializable()
@NullDateTimeConverter()
@BooleanConverter()
class VKPhoto extends Equatable {
  final int id;
  @JsonKey(name: 'album_id')
  final int albumId;
  @JsonKey(name: 'owner_id')
  final int ownerId;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'has_tags')
  final bool? hasTags;
  final String? text;
  final DateTime? date;
  final List<VKPhotoSize>? sizes;
  final int? width;
  final int? height;

  const VKPhoto(
    this.id,
    this.albumId,
    this.ownerId, [
    this.userId,
    this.hasTags,
    this.text,
    this.date,
    this.sizes,
    this.width,
    this.height,
  ]);

  static const VKPhoto empty = VKPhoto(0, 0, 0);

  factory VKPhoto.fromJson(Map<String, dynamic> json) => _$VKPhotoFromJson(json);
  Map<String, dynamic> toJson() => _$VKPhotoToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, albumId, ownerId, userId, hasTags, text, date, sizes, width, height];
}
