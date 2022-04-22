import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vk_group.g.dart';

@JsonSerializable()
class VKGroup extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'screen_name')
  final String? screenName;
  @JsonKey(name: 'photo_50')
  final String? photo50;

  const VKGroup(this.id, this.name, [this.screenName, this.photo50]);

  static const VKGroup empty = VKGroup(0, '');

  factory VKGroup.fromJson(Map<String, dynamic> json) => _$VKGroupFromJson(json);
  Map<String, dynamic> toJson() => _$VKGroupToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        id,
        name,
        screenName,
        photo50,
      ];
}
