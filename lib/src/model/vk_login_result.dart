import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'converter.dart';
import 'vk_access_token.dart';

part 'vk_login_result.g.dart';

/// Result for login request.
@JsonSerializable()
@BooleanConverter()
class VKLoginResult extends Equatable {
  /// `true` if log in process canceled by user.
  final bool isCanceled;

  /// Access token.
  ///
  /// `null` if user log in failed.
  final VKAccessToken? accessToken;

  const VKLoginResult(this.accessToken, {required this.isCanceled});

  factory VKLoginResult.fromJson(Map<String, dynamic> json) => _$VKLoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$VKLoginResultToJson(this);

  @override
  List<Object?> get props => [isCanceled, accessToken];
}
