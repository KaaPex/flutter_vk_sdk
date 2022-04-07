import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vk_video_image.g.dart';

@JsonSerializable()
class VKVideoImage extends Equatable {
  final int height;
  final String url;
  final int width;
  @JsonKey(name: 'with_padding')
  final int? withPadding;

  const VKVideoImage(this.height, this.url, this.width, [this.withPadding]);

  static const VKVideoImage empty = VKVideoImage(0, '', 0);

  factory VKVideoImage.fromJson(Map<String, dynamic> json) => _$VKVideoImageFromJson(json);
  Map<String, dynamic> toJson() => _$VKVideoImageToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [height, url, width, withPadding];
}
