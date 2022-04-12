import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/model/converter.dart';

part 'vk_access_token.g.dart';

/// VK access token.
@JsonSerializable()
@NullDateTimeConverter()
@BooleanConverter()
class VKAccessToken extends Equatable {
  final String token;
  final String userId;
  final DateTime? created;
  final String? email;
  final bool isValid;
  final String? secret;
  final String? phone;
  final String? phoneAccessKey;

  const VKAccessToken(
    this.userId,
    this.token,
    this.isValid, [
    this.created,
    this.email,
    this.secret,
    this.phone,
    this.phoneAccessKey,
  ]);

  factory VKAccessToken.fromJson(Map<String, dynamic> json) => _$VKAccessTokenFromJson(json);
  Map<String, dynamic> toJson() => _$VKAccessTokenToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        token,
        userId,
        created,
        email,
        isValid,
        secret,
        phone,
        phoneAccessKey,
      ];
}
