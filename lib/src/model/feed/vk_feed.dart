import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../vk_models.dart';
import 'vk_feed_item.dart';

part 'vk_feed.g.dart';

@JsonSerializable()
class VKFeed extends Equatable {
  @JsonKey(name: 'next_from')
  final int nextFrom;
  @JsonKey(name: 'new_offset')
  final int newOffset;
  final List<VKFeedItem> items;
  final List<VKUserProfile?>? profiles;
  final List<VKGroup?>? groups;

  const VKFeed({
    required this.nextFrom,
    required this.newOffset,
    required this.items,
    this.profiles,
    this.groups,
  });

  static const VKFeed empty = VKFeed(nextFrom: 0, newOffset: 0, items: []);

  factory VKFeed.fromJson(Map<String, dynamic> json) => _$VKFeedFromJson(json);
  Map<String, dynamic> toJson() => _$VKFeedToJson(this);

  VKFeed copyWith({
    int? nextFrom,
    int? newOffset,
    List<VKFeedItem>? items,
    List<VKUserProfile>? profiles,
    List<VKGroup>? groups,
  }) {
    return VKFeed(
      nextFrom: nextFrom ?? this.nextFrom,
      newOffset: newOffset ?? this.newOffset,
      items: items ?? this.items,
      profiles: profiles ?? this.profiles,
      groups: groups ?? this.groups,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        nextFrom,
        items,
        profiles,
        groups,
      ];
}
