import 'package:flutter/foundation.dart';

enum VKScope {
  notify,
  friends,
  photos,
  audio,
  video,
  stories,
  pages,
  status,
  notes,
  messages,
  wall,
  ads,
  offline,
  docs,
  groups,
  notifications,
  stats,
  email,
  market,
  // Need to pass moderation for this scope. Check this: https://vk.com/dev/permissions
  pbone
}

extension VKScopeExtension on VKScope {
  /// Name of scope.
  String get name => describeEnum(this);
}
