import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/model/vk_post.dart';

part 'vk_wall.g.dart';

@JsonSerializable()
class VKWall extends Equatable {
  final int count;
  final List<VKPost> items;

  const VKWall(this.count, this.items);

  static const VKWall empty = VKWall(0, []);

  factory VKWall.fromJson(Map<String, dynamic> json) => _$VKWallFromJson(json);
  Map<String, dynamic> toJson() => _$VKWallToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        count,
        items,
      ];
}
