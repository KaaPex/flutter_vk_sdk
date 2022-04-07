import 'package:flutter/foundation.dart';

enum VKScopeCommunity {
  stories,
  photos,
  app_widget,
  messages,
  docs,
  manage,
}

extension VKScopeCommunityExtension on VKScopeCommunity {
  /// Name of scope.
  String get name => describeEnum(this);
}
