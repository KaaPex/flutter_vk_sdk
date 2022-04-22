import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/constants/vk_feed_item_type.dart';
import 'package:vk_sdk/src/model/converter.dart';

import '../vk_models.dart';

part 'vk_feed_item.g.dart';

@JsonSerializable()
@NullDateTimeConverter()
@VKFeedItemTypeConverter()
class VKFeedItem extends Equatable {
  /// Item source ID
  @JsonKey(name: 'source_id')
  final int? sourceId;

  /// Post creator ID (if post still can be edited)
  @JsonKey(name: 'created_by')
  final int? createdBy;

  /// Topic ID. Allowed values can be obtained from newsfeed.getPostTopics method
  @JsonKey(name: 'topic_id')
  final int? topicId;

  /// Post author ID
  @JsonKey(name: 'from_id')
  final int? fromId;

  /// Post ID
  final int? id;

  /// Wall owner's ID
  @JsonKey(name: 'owner_id')
  final int? ownerId;

  /// If post type 'reply', contains original post ID
  @JsonKey(name: 'post_id')
  final int? postId;

  ///  Post signer ID
  @JsonKey(name: 'signer_id')
  final int? signerId;

  /// type
  final VKFeedItemType type;

  /// Date when item has been added in Unixtime
  final DateTime? date;

  /// Access key to private object
  @JsonKey(name: 'access_key')
  final String? accessKey;

  /// Post text
  final String? text;

  /// Original post
  @JsonKey(name: 'copy_history')
  final List<VKPost>? copyHistory;

  /// post attachments
  final List<VKWallAttachment?>? attachments;

  /// Count of likes
  final VKBaseLikes? likes;

  /// Count of views
  final VKBaseViews? views;

  const VKFeedItem({
    required this.type,
    this.sourceId,
    this.createdBy,
    this.topicId,
    this.fromId,
    this.id,
    this.ownerId,
    this.postId,
    this.signerId,
    this.date,
    this.accessKey,
    this.text,
    this.copyHistory,
    this.attachments,
    this.likes,
    this.views,
  });

  static const VKFeedItem empty = VKFeedItem(type: VKFeedItemType.unknown);

  factory VKFeedItem.fromJson(Map<String, dynamic> json) => _$VKFeedItemFromJson(json);
  Map<String, dynamic> toJson() => _$VKFeedItemToJson(this);

  VKFeedItem copyWith({
    VKFeedItemType? type,
    int? sourceId,
    DateTime? date,
    String? accessKey,
    List<VKPost>? copyHistory,
    List<VKWallAttachment>? attachments,
    VKBaseLikes? likes,
    VKBaseViews? views,
  }) {
    return VKFeedItem(
      type: type ?? this.type,
      sourceId: sourceId ?? this.sourceId,
      date: date ?? this.date,
      accessKey: accessKey ?? this.accessKey,
      copyHistory: copyHistory ?? this.copyHistory,
      attachments: attachments ?? this.attachments,
      likes: likes ?? this.likes,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [
        type,
        sourceId,
        createdBy,
        topicId,
        fromId,
        id,
        ownerId,
        postId,
        signerId,
        date,
        accessKey,
        text,
        copyHistory,
        attachments,
        likes,
        views,
      ];
}
