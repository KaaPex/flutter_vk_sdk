import 'dart:collection';
import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:vk_sdk/vk_sdk.dart';

class VKMethodCall {
  final _methodStr = 'method';
  final _argumentsStr = 'arguments';
  final _retryCountStr = 'retry_count';
  final _skipValidationStr = 'skip_validation';
  final String _channelMethod = 'api_method_call';
  final String endpoint;
  final int retryCount;
  final bool skipValidation;
  final Map<dynamic, dynamic> _args = {};

  VKMethodCall(this.endpoint, [this.retryCount = 3, this.skipValidation = false]);

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

  Future callMethod() async {
    final Map<String, dynamic> request = {
      _methodStr: endpoint,
      _retryCountStr: retryCount,
      _skipValidationStr: skipValidation
    };
    if (_args.isNotEmpty) request[_argumentsStr] = _args;

    try {
      final res = await channel.invokeMethod<String>(getChannelMethod(), request);
      return Result.value(parse(res!));
    } on PlatformException catch (e) {
      return Result.error(e);
    }
  }

  parse(String response) {
    final data = jsonDecode(response);
    return data['response'] ?? data;
  }

  static Map<String, dynamic> _cast(Map items) {
    return items.cast<String, dynamic>();
  }
}
