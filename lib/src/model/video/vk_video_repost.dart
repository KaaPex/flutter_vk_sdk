import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../converter.dart';

part 'vk_video_repost.g.dart';

@JsonSerializable()
@NullBooleanConverter()
class VKVideoRepost extends Equatable {
  final int count;
  @JsonKey(name: 'wall_count')
  final int? wallCount;
  @JsonKey(name: 'mail_count')
  final int? mailCount;
  @JsonKey(name: 'user_reposted')
  final bool? userReposted;

  const VKVideoRepost(
    this.count, [
    this.wallCount,
    this.mailCount,
    this.userReposted,
  ]);

  static const VKVideoRepost empty = VKVideoRepost(0);

  factory VKVideoRepost.fromJson(Map<String, dynamic> json) => _$VKVideoRepostFromJson(json);
  Map<String, dynamic> toJson() => _$VKVideoRepostToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        count,
        wallCount,
        mailCount,
        userReposted,
      ];
}
