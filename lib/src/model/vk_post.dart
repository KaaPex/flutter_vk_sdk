import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/model/converter.dart';

part 'vk_post.g.dart';

@JsonSerializable()
@DateTimeConverter()
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

  const VKPost(this.id, this.ownerId, this.fromId, this.date, [this.createdBy, this.text]);

  factory VKPost.fromJson(Map<String, dynamic> json) => _$VKPostFromJson(json);
  Map<String, dynamic> toJson() => _$VKPostToJson(this);

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
      ];
}
