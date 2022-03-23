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
                      isLogin
                          ? OutlinedButton(
                              child: const Text('Log Out'),
                              onPressed: () {},
                            )
                          : OutlinedButton(
                              child: const Text('Log In'),
                              onPressed: () => _onPressedLogInButton(context),
                            ),
                    ]),
                  ),
                ))));
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
      if (loginResult.isCanceled) {}
    }
  }

  Future<void> _initSdk() async {
    await widget.vkSdkPlugin.initSdk();
    _sdkInitialized = true;
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await VkSdk.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }
}
