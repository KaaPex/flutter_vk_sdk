import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vk_sdk/src/constants/constants.dart';

import '../converter.dart';

part 'vk_photo_size.g.dart';

@JsonSerializable()
@VKPhotoSizeTypeConverter()
class VKPhotoSize extends Equatable {
  final int height;
  final String url;
  final VKPhotoSizeType type;
  final int width;

  const VKPhotoSize(this.height, this.url, this.width, this.type);

  static const VKPhotoSize empty = VKPhotoSize(0, '', 0, VKPhotoSizeType.w);

  factory VKPhotoSize.fromJson(Map<String, dynamic> json) => _$VKPhotoSizeFromJson(json);
  Map<String, dynamic> toJson() => _$VKPhotoSizeToJson(this);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [height, url, width, type];
}
