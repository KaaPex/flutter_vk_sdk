library vk_sdk;

import 'dart:convert';

import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'src/api/vk_api.dart';
import 'src/constants/vk_scope.dart';
import 'src/model/vk_access_token.dart';
import 'src/model/vk_login_result.dart';
import 'src/model/base/base.dart';

export 'src/constants/constants.dart';
export 'src/model/vk_models.dart';
export 'src/vk_method_call.dart';
export 'src/vk_scope.dart';

class VkSdk {
  static final api = VKApi();
  bool _initialized = false;

  // Methods
  static const _methodInitSdk = 'initSdk';
  static const _methodGetSdkVersion = 'getSdkVersion';
  static const _methodGetPlatformVersion = 'getPlatformVersion';
  static const _methodLogIn = 'logIn';
  static const _methodLogOut = 'logOut';
  static const _methodIsLoggedIn = 'isLoggedIn';
  static const _methodGetAccessToken = 'getAccessToken';
  static const _methodGetUserId = 'getUserId';
  static const _callMethod = 'api_method_call';

  /// If `true` all requests and results will be printed in console.
  final bool debug;

  VkSdk({this.debug = false});

  static const MethodChannel _channel = MethodChannel('vk_sdk');
  static MethodChannel get channel => _channel;

  /// Return `true` if SDK initialized.
  bool get isInitialized => _initialized;

  /// Returns currently used VK SDK.
  static Future<String?> get sdkVersion async {
    final res = await _channel.invokeMethod<String>(_methodGetSdkVersion);
    return res;
  }

  /// Returns currently used platform version.
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod(_methodGetPlatformVersion);
    return version;
  }

  /// Initialize SDK.
  ///
  /// Should call before any other method calls.
  ///
  /// You can pass [scope] (and/or [customScope], see [logIn])
  /// to require listed permissions. If user logged in,
  /// but doesn't have all of this permissions - he will be logged out.
  Future<Result<bool>> initSdk({List<VKScope>? scope, List<String>? customScope}) async {
    final scopeArg = _getScope(scope: scope, customScope: customScope);

    _log('InitSdk with scope $scopeArg');

    try {
      final result = await _channel.invokeMethod<bool>(_methodInitSdk, {
        'scope': scopeArg,
      });

      if (result == true) {
        _initialized = true;
        return Result.value(true);
      } else {
        _initialized = false;
        return Result.error('Init SDK failed');
      }
    } on PlatformException catch (e) {
      _log('Init SDK error: $e');
      return Result.error(e);
    }
  }

  Future<Result<VKLoginResult>> logIn({List<VKScope> scope = const [], List<String>? customScope}) async {
    assert(_initialized, 'SDK is not initialized. You should call initSdk() first');
    if (!_initialized) throw Exception('SDK is not initialized.');

    final scopeArg = _getScope(scope: scope, customScope: customScope);

    _log('Log In with scope $scopeArg');

    try {
      final res = await _channel.invokeMethod<Map<dynamic, dynamic>>(_methodLogIn, {'scope': scopeArg});

      if (res == null) {
        return Result.error('Invalid null result');
      } else {
        return Result.value(VKLoginResult.fromJson(res.cast<String, dynamic>()));
      }
    } on PlatformException catch (e) {
      _log('Log In error: $e');
      return Result.error(e);
    }
  }

  Future<void> logOut() async {
    assert(_initialized, 'SDK is not initialized. You should call initSdk() first');
    if (!_initialized) return;

    _log('Log Out');
    await _channel.invokeMethod<void>(_methodLogOut);
  }

  /// Returns access token if user logged in.
  ///
  /// If user is now logged in, than returns `null`.
  Future<VKAccessToken?> get accessToken async {
    assert(_initialized, 'SDK is not initialized. You should call initSdk() first');
    if (!_initialized) return null;

    final tokenResult = await _channel.invokeMethod<Map<dynamic, dynamic>>(_methodGetAccessToken);

    return tokenResult != null ? VKAccessToken.fromJson(tokenResult.cast<String, dynamic>()) : null;
  }

  static Future<bool> get isLoggedIn async {
    final res = await _channel.invokeMethod<bool>(_methodIsLoggedIn);
    return res ?? false;
  }

  static Future<int?> get userId async {
    final res = await _channel.invokeMethod<String>(_methodGetUserId);
    return int.parse(res ?? "");
  }

  Future<Result<VKUserProfile?>> getUserProfile() async {
    if (await isLoggedIn == false) {
      _log('Not logged in. User profile is null');
      return Result.value(null);
    }

    try {
      final Map<String, dynamic> request = {
        'method': 'users.get',
        'retry_count': 3,
        'skip_validation': false,
        'arguments': <String, dynamic>{
          'user_ids': (await userId).toString(),
          'fields': 'online,photo_50,photo_100,photo_200'
        }
      };

      final result = await channel.invokeMethod<String>(_callMethod, request);

      _log('User profile: $result');

      return Result.value(
          result != null ? VKUserProfile.fromJson(jsonDecode(result)['response'][0].cast<String, dynamic>()) : null);
    } on PlatformException catch (e) {
      _log('Get profile error: $e');
      return Result.error(e);
    }
  }

  List<String>? _getScope({List<VKScope>? scope, List<String>? customScope}) {
    if (scope != null) {
      final scopeArg = scope.map((e) => e.name).toList();
      if (customScope != null) scopeArg.addAll(customScope);
      return scopeArg;
    } else if (customScope != null) {
      return List.from(customScope);
    } else {
      return null;
    }
  }

  void _log(String message) {
    if (debug) debugPrint('[VK] $message');
  }
}
