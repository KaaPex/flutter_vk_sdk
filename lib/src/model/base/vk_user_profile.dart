import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'vk_user_counters.dart';

import '../converter.dart';

part 'vk_user_profile.g.dart';

@JsonSerializable()
@BooleanConverter()
class VKUserProfile extends Equatable {
  @JsonKey(name: 'id')
  final int userId;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String nickname;
  final String? domain;
  @JsonKey(name: 'screen_name')
  final String? screenName;
  final bool online;
  final String? status;
  @JsonKey(name: 'status_audio')
  final String? statusAudio;
  @JsonKey(name: 'online_mobile')
  final bool onlineMobile;
  @JsonKey(name: 'online_app')
  final bool onlineApp;
  @JsonKey(name: 'photo_50')
  final String? photo50;
  @JsonKey(name: 'photo_100')
  final String? photo100;
  @JsonKey(name: 'photo_200')
  final String? photo200;
  @JsonKey(name: 'is_closed')
  final bool? isClosed;
  @JsonKey(name: 'can_access_closed')
  final bool? canAccessClosed;
  final VKUserCounters? counters;

  const VKUserProfile(this.userId, this.firstName, this.lastName,
      [this.nickname = '',
      this.domain,
      this.screenName,
      this.status,
      this.statusAudio,
      this.online = false,
      this.onlineMobile = false,
      this.onlineApp = false,
      this.photo50,
      this.photo100,
      this.photo200,
      this.isClosed = false,
      this.canAccessClosed = false,
      this.counters]);

  static const VKUserProfile empty = VKUserProfile(0, '', '');

  factory VKUserProfile.fromJson(Map<String, dynamic> json) => _$VKUserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$VKUserProfileToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        nickname,
        domain,
        screenName,
        status,
        statusAudio,
        online,
        onlineMobile,
        onlineApp,
        photo50,
        photo100,
        photo200,
        isClosed,
        canAccessClosed,
        counters
      ];
}
