import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/model/converter.dart';

part 'vk_base_views.g.dart';

@JsonSerializable()
@NullBooleanConverter()
class VKBaseViews extends Equatable {
  /// Likes number
  final int? count;

  const VKBaseViews(this.count);

  factory VKBaseViews.fromJson(Map<String, dynamic> json) => _$VKBaseViewsFromJson(json);
  Map<String, dynamic> toJson() => _$VKBaseViewsToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [count];
}
