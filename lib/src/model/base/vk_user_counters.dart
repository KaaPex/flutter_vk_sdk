import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vk_user_counters.g.dart';

@JsonSerializable()
class VKUserCounters extends Equatable {
  final int? albums;
  final int? videos;
  final int? audios;
  final int? photos;
  final int? notes;
  final int? friends;
  final int? groups;
  @JsonKey(name: 'online_friends')
  final int? onlineFriends;
  @JsonKey(name: 'mutual_friends')
  final int? mutualFriends;
  @JsonKey(name: 'user_videos')
  final int? userVideos;
  @JsonKey(name: 'clips_followers')
  final int? clipsFollowers;
  final int? followers;
  final int? pages;
  final int? subscriptions;

  const VKUserCounters(
      this.albums,
      this.videos,
      this.audios,
      this.photos,
      this.notes,
      this.friends,
      this.groups,
      this.onlineFriends,
      this.mutualFriends,
      this.userVideos,
      this.followers,
      this.pages,
      this.clipsFollowers,
      this.subscriptions);

  factory VKUserCounters.fromJson(Map<String, dynamic> json) => _$VKUserCountersFromJson(json);
  Map<String, dynamic> toJson() => _$VKUserCountersToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        albums,
        videos,
        audios,
        photos,
        notes,
        friends,
        groups,
        onlineFriends,
        mutualFriends,
        userVideos,
        followers,
        pages,
        clipsFollowers,
        subscriptions
      ];
}
