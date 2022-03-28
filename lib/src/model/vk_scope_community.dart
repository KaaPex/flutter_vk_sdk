import 'package:flutter/foundation.dart';

enum VKScopeCommunity { stories, photos, app_widget, messages, docs, manage }

extension VKScopeExtension on VKScopeCommunity {
  /// Name of scope.
  String get name => describeEnum(this);
}
