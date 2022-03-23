# vk_sdk

A VK sdk plugin based on native official Android and iOS sdk

## SDK version

VK SDK version, used in plugin:
* iOS: **^1.6.2** ([CocoaPods](https://cocoapods.org/pods/VK-ios-sdk))
* Android: **3.5.1** (Maven [core](https://search.maven.org/artifact/com.vk/android-sdk-core), [api](https://search.maven.org/artifact/com.vk/android-sdk-api))

## Minimum requirements

* iOS **9.0** and higher.
* Android **5.0** and newer (SDK **21**). Minimum `compileSdkVersion` **31**.

Features:
* log in via VK.com;
* get access token;
* check if logged in;
* log out.
* 100% coverage of the VK API

#### Initialization notes

When you call `initSdk()`, plugin try to restore previous session.
If token has been expired - it will be refreshed.

Also, during restoring, log in screen may be shown to user
(only if user was logged in).

In additional, you can pass to `initSdk()` required `scope`,
and if current user session doesn't provide it - user will be
logged out.