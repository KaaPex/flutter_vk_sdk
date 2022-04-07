import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/model/converter.dart';

part 'vk_base_likes.g.dart';

@JsonSerializable()
@NullBooleanConverter()
class VKBaseLikes extends Equatable {
  /// Likes number
  final int? count;

  /// Information whether current user likes the photo
  @JsonKey(name: 'user_likes')
  final bool? userLikes;

  const VKBaseLikes(this.count, this.userLikes);

  factory VKBaseLikes.fromJson(Map<String, dynamic> json) => _$VKBaseLikesFromJson(json);
  Map<String, dynamic> toJson() => _$VKBaseLikesToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        count,
        userLikes,
      ];
}
