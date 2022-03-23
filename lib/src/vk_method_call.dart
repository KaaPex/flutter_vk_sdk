import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:vk_sdk/vk_sdk.dart';

class VKMethodCall {
  late String _channelMethod;
  final Map<dynamic, dynamic> _args = {};

  MethodChannel get channel => VkSdk.channel;
  UnmodifiableMapView<dynamic, dynamic> get args => UnmodifiableMapView(_args);

  bool isEmptyKey(String? value) {
    return value?.isNotEmpty != true;
  }

  bool isEmptyValue(String? value) {
    return value?.isNotEmpty != true;
  }

  set args(Map<dynamic, dynamic>? values) {
    if (values == null) return;

    final items = <String, dynamic>{};
    values.forEach((k, v) {
      if (!isEmptyKey(k) && !isEmptyKey(v)) items[k] = v;
    });
    _args.addAll(items);
  }

  setValue(String key, dynamic value) {
    final val = value is String ? value : value?.toString();
    if (isEmptyKey(key) || isEmptyValue(val)) return;
    _args[key] = val;
  }

  setBool(String key, bool? value) {
    if (isEmptyValue(key) || value == null) return;
    _args[key] = (value ? 1 : 0).toString();
  }

  String getChannelMethod() {
    assert(_channelMethod.isNotEmpty == true);
    return _channelMethod;
  }

  Future callMethod([dynamic arguments]) {
    return channel.invokeMethod<Map<dynamic, dynamic>>(
        getChannelMethod(), arguments);
  }
}
