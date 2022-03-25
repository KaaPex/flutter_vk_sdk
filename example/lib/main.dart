import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:vk_sdk/vk_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  final vkSdkPlugin = VkSdk(debug: true);

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String? _sdkVersion;
  bool _sdkInitialized = false;
  VKAccessToken? _token;
  int? _userId;
  VKUserProfile? _profile;

  @override
  void initState() {
    super.initState();

    _getSdkVersion();
    _initSdk();

    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await VkSdk.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    final token = _token;
    final profile = _profile;
    final isLogin = token != null;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
                child: Builder(
                  builder: (context) => Center(
                    child: Column(children: [
                      Center(
                        child: Text('Running on: $_platformVersion\n'),
                      ),
                      Center(
                        child: Text('Vk SDK: $_sdkVersion\n'),
                      ),
                      if (token != null && profile != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _buildUserInfo(context, profile, token, ''),
                        ),
                      isLogin
                          ? OutlinedButton(
                              child: const Text('Log Out'),
                              onPressed: _onPressedLogoutButton,
                            )
                          : OutlinedButton(
                              child: const Text('Log In'),
                              onPressed: () => _onPressedLogInButton(context),
                            ),
                    ]),
                  ),
                ))));
  }

  Widget _buildUserInfo(BuildContext context, VKUserProfile profile,
      VKAccessToken accessToken, String? email) {
    final photoUrl = profile.photo200;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('User: '),
        Text(
          '${profile.firstName} ${profile.lastName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Online: ${profile.online}, Online mobile: ${profile.onlineMobile}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (photoUrl != null) Image.network(photoUrl),
        const Text('AccessToken: '),
        Text(
          accessToken.token,
          softWrap: true,
        ),
        Text('Created: ${accessToken.created}'),
        if (email != null) Text('Email: $email'),
      ],
    );
  }

  Future<void> _onPressedLogInButton(BuildContext context) async {
    final res = await widget.vkSdkPlugin.logIn(scope: [
      VKScope.email,
    ]);

    if (res.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log In failed: ${res.asError!.error}'),
        ),
      );
    } else {
      final loginResult = res.asValue!.value;
      if (!loginResult.isCanceled) {
        _updateLoginInfo();
      }
    }
  }

  Future<void> _onPressedLogoutButton() async {
    await widget.vkSdkPlugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _initSdk() async {
    await widget.vkSdkPlugin.initSdk();
    _sdkInitialized = true;
    _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await VkSdk.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo() async {
    if (!_sdkInitialized) return;

    final token = await widget.vkSdkPlugin.accessToken;
    final userId = token != null ? await VkSdk.userId : null;

    var profile =
        token != null ? await widget.vkSdkPlugin.getUserProfile() : null;

    setState(() {
      _token = token;
      _userId = userId;
      _profile = profile?.asValue?.value;
    });
  }
}
