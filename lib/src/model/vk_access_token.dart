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
  final String? secret;
  final DateTime? created;
  final String? email;
  final String? phone;
  final String? phoneAccessKey;
  @JsonKey(name: 'httpsRequired')
  final bool httpsRequired;
  @JsonKey(name: 'expiresIn')
  final int expirationDate;

  const VKAccessToken(this.userId, this.token,
      [this.secret,
      this.created,
      this.email,
      this.phone,
      this.phoneAccessKey,
      this.httpsRequired = true,
      this.expirationDate = -1]);

  factory VKAccessToken.fromJson(Map<String, dynamic> json) => _$VKAccessTokenFromJson(json);
  Map<String, dynamic> toJson() => _$VKAccessTokenToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, userId, secret, created, email];
}
