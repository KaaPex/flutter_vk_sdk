import 'package:flutter/foundation.dart';

enum VKVideoLiveStatus {
  waiting,
  started,
  finished,
  failed,
  upcoming,
}

extension VKVideoLiveStatusExtension on VKVideoLiveStatus {
  /// Name of scope.
  String get name => describeEnum(this);
}
