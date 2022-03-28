import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'converter.dart';

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
  final bool online;
  @JsonKey(name: 'online_mobile')
  final bool onlineMobile;
  @JsonKey(name: 'photo_50')
  final String? photo50;
  @JsonKey(name: 'photo_100')
  final String? photo100;
  @JsonKey(name: 'photo_200')
  final String? photo200;

  const VKUserProfile(this.userId, this.firstName, this.lastName,
      [this.online = false,
      this.onlineMobile = false,
      this.photo50,
      this.photo100,
      this.photo200]);

  factory VKUserProfile.fromJson(Map<String, dynamic> json) =>
      _$VKUserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$VKUserProfileToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        online,
        onlineMobile,
        photo50,
        photo100,
        photo200
      ];
}
