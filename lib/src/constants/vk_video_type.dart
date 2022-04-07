import 'package:flutter/foundation.dart';

enum VKVideoType {
  video,
  music_video,
  movie,
}

extension VKVideoTypeExtension on VKVideoType {
  /// Name of scope.
  String get name => describeEnum(this);
}
