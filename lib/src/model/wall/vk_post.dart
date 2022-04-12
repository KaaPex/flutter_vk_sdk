import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/model/converter.dart';
import 'package:vk_sdk/src/model/vk_models.dart';

part 'vk_post.g.dart';

@JsonSerializable()
@NullDateTimeConverter()
class VKPost extends Equatable {
  final int id;
  @JsonKey(name: 'owner_id')
  final int ownerId;
  @JsonKey(name: 'from_id')
  final int fromId;
  @JsonKey(name: 'created_by')
  final int? createdBy;
  final DateTime? date;
  final String? text;
  final List<VKWallAttachment?>? attachments;
  @JsonKey(name: 'copy_history')
  final List<VKPost>? copyHistory;
  @JsonKey(ignore: true)
  final VKUserProfile? profile;
  @JsonKey(ignore: true)
  final VKGroup? group;

  const VKPost(
    this.id,
    this.ownerId,
    this.fromId, [
    this.date,
    this.createdBy,
    this.text,
    this.copyHistory,
    this.attachments,
    this.profile,
    this.group,
  ]);

  static const VKPost empty = VKPost(0, 0, 0);

  factory VKPost.fromJson(Map<String, dynamic> json) => _$VKPostFromJson(json);
  Map<String, dynamic> toJson() => _$VKPostToJson(this);

  VKPost copyWith({
    int? id,
    int? ownerId,
    int? fromId,
    DateTime? date,
    int? createdBy,
    String? text,
    List<VKPost>? copyHistory,
    List<VKWallAttachment>? attachments,
    VKUserProfile? profile,
    VKGroup? group,
  }) {
    return VKPost(
      id ?? this.id,
      ownerId ?? this.ownerId,
      fromId ?? this.fromId,
      date ?? this.date,
      createdBy ?? this.createdBy,
      text ?? this.text,
      copyHistory ?? this.copyHistory,
      attachments ?? this.attachments,
      profile ?? this.profile,
      group ?? this.group,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        ownerId,
        fromId,
        createdBy,
        date,
        text,
        copyHistory,
        attachments,
        profile,
        group,
      ];
}
