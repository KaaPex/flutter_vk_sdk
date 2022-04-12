import Flutter
import UIKit
import VK_ios_sdk

/// Plugin methods.
enum VkSdkPluginMethod: String {
    case getPlatformVersion
    case getSdkVersion
    case getAccessToken
    case initSdk
    case getUserId
    case logIn
    case logOut
    case isLoggedIn
    case getUserProfile
    case api_method_call
    case post_method_call
}

/// Arguments for method `VKMethod.initSdk`
enum InitSdkArg: String {
    case scope
}

/// Arguments for method `VKMethod.logIn`
enum LogInArg: String {
    case scope
}

public class SwiftVkSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "vk_sdk", binaryMessenger: registrar.messenger())
    let instance = SwiftVkSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  private lazy var _uiDelegate = VkUIDelegate()
  private lazy var _loginDelegate = VkLogInDelegate()
  private var _sdk: VKSdk?

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let method = VkSdkPluginMethod(rawValue: call.method) else {
        result(FlutterMethodNotImplemented)
        return
    }

    switch method {
    case .getPlatformVersion:
    case .getSdkVersion:
    case .getAccessToken:
        getAccessToken(result: result)
    case .initSdk:


    }
  }

  private func getAccessToken(result: @escaping FlutterResult) {
      let token = VKSdk.accessToken()
      result(token?.toMap())
  }
}
