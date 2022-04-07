import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/constants/vk_attachment_type.dart';

import 'converter.dart';
import 'photo/vk_photo.dart';
import 'video/vk_video.dart';
import 'vk_audio.dart';

part 'vk_wall_attachment.g.dart';

@JsonSerializable()
@VKAttachmentTypeConverter()
class VKWallAttachment extends Equatable {
  final VKAttachmentType type;
  @JsonKey(name: 'access_key')
  final String? accessKey;
  // final String? album;
  // final String? app;
  final VKAudio? audio;
  // final String? doc;
  // final String? event;
  // final String? group;
  // final String? graffiti;
  // final String? link;
  // final String? market;
  // @JsonKey(name: 'market_album')
  // final String? marketAlbum;
  // final String? note;
  // final String? page;
  final VKPhoto? photo;
  // final String? poll;
  // @JsonKey(name: 'posted_photo')
  // final String? postedPhoto;
  // @JsonKey(ignore: true)
  final VKVideo? video;

  const VKWallAttachment(
    this.type, [
    this.accessKey,
    // this.album,
    // this.app,
    this.audio,
    // this.doc,
    // this.event,
    // this.group,
    // this.graffiti,
    // this.link,
    // this.market,
    // this.marketAlbum,
    // this.note,
    // this.page,
    this.photo,
    // this.poll,
    // this.postedPhoto,
    this.video,
  ]);

  static const VKWallAttachment empty = VKWallAttachment(VKAttachmentType.photo);

  factory VKWallAttachment.fromJson(Map<String, dynamic> json) => _$VKWallAttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$VKWallAttachmentToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        type,
        accessKey,
        // album,
        // app,
        audio,
        // doc,
        // event,
        // group,
        // graffiti,
        // link,
        // market,
        // marketAlbum,
        // note,
        // page,
        photo,
        // poll,
        // postedPhoto,
        video,
      ];
}
