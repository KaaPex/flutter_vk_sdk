import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/constants/constants.dart';

import '../converter.dart';
import '../base/vk_base_likes.dart';
import 'vk_video_image.dart';
import 'vk_video_repost.dart';

part 'vk_video.g.dart';

@JsonSerializable()
@NullDateTimeConverter()
@NullBooleanConverter()
@VKVideoLiveStatusConverter()
class VKVideo extends Equatable {
  final int? id;
  @JsonKey(name: 'owner_id')
  final int? ownerId;
  @JsonKey(name: 'user_id')
  final int? userId;
  final String? title;
  final String? description;
  final int? duration;
  final List<VKVideoImage>? image;
  @JsonKey(name: 'first_frame')
  final List<VKVideoImage>? firstFrame;
  final DateTime? date;
  @JsonKey(name: 'adding_date')
  final DateTime? addingDate;
  final int? views;
  @JsonKey(name: 'local_views')
  final int? localViews;
  final int? comments;
  final String? player;
  final String? platform;
  @JsonKey(name: 'can_add')
  final bool? canAdd;
  @JsonKey(name: 'is_private')
  final bool? isPrivate;
  @JsonKey(name: 'access_key')
  final String? accessKey;
  final bool? processing;
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @JsonKey(name: 'can_comment')
  final bool? canComment;
  @JsonKey(name: 'can_edit')
  final bool? canEdit;
  @JsonKey(name: 'can_like')
  final bool? canLike;
  @JsonKey(name: 'can_repost')
  final bool? canRepost;
  @JsonKey(name: 'can_subscribe')
  final bool? canSubscribe;
  @JsonKey(name: 'can_add_to_faves')
  final bool? canAddToFaves;
  @JsonKey(name: 'can_attach_link')
  final bool? canAttachLink;
  final int? width;
  final int? height;
  final bool? converting;
  final bool? added;
  @JsonKey(name: 'is_subscribed')
  final bool? isSubscribed;
  final bool? repeat;
  final VKVideoType? type;
  @JsonKey(name: 'track_code')
  final String? trackCode;
  final int? balance;
  @JsonKey(name: 'live_status')
  final VKVideoLiveStatus? liveStatus;
  final bool? live;
  final bool? upcoming;
  final int? spectators;
  final VKBaseLikes? likes;
  final VKVideoRepost? reposts;

  const VKVideo([
    this.id,
    this.ownerId,
    this.userId,
    this.title,
    this.description,
    this.duration,
    this.image,
    this.firstFrame,
    this.date,
    this.addingDate,
    this.views,
    this.localViews,
    this.comments,
    this.player,
    this.platform,
    this.canAdd,
    this.isPrivate,
    this.accessKey,
    this.processing,
    this.isFavorite = false,
    this.canComment,
    this.canEdit,
    this.canLike,
    this.canRepost,
    this.canSubscribe,
    this.canAddToFaves,
    this.canAttachLink,
    this.width,
    this.height,
    this.converting,
    this.added,
    this.isSubscribed,
    this.repeat,
    this.type,
    this.trackCode,
    this.balance,
    this.liveStatus,
    this.live,
    this.upcoming,
    this.spectators,
    this.likes,
    this.reposts,
  ]);

  static const VKVideo empty = VKVideo();

  factory VKVideo.fromJson(Map<String, dynamic> json) => _$VKVideoFromJson(json);
  Map<String, dynamic> toJson() => _$VKVideoToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        userId,
        title,
        description,
        duration,
        image,
        firstFrame,
        date,
        addingDate,
        views,
        localViews,
        comments,
        player,
        platform,
        canAdd,
        isPrivate,
        accessKey,
        processing,
        isFavorite,
        canComment,
        canEdit,
        canLike,
        canRepost,
        canSubscribe,
        canAddToFaves,
        canAttachLink,
        width,
        height,
        converting,
        added,
        isSubscribed,
        repeat,
        type,
        trackCode,
        balance,
        liveStatus,
        live,
        upcoming,
        spectators,
        likes,
        reposts,
      ];
}
