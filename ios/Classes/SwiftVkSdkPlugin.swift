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
    case appId, apiVersion, scope
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
    
    //   private lazy var _uiDelegate = VkUIDelegate()
    //   private lazy var _loginDelegate = VkLogInDelegate()
    private var _sdk: VKSdk?
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = VkSdkPluginMethod(rawValue: call.method)
        else {
            result(FlutterMethodNotImplemented)
            return
        }
        
        switch method {
        case .getPlatformVersion:
            result("iOS " + UIDevice.current.systemVersion)
        case .getSdkVersion:
            getSdkVersion(result: result)
        case .getAccessToken:
            getAccessToken(result: result)
        case .initSdk:
            guard
                let args = call.arguments as? [String: Any],
                let appIdArg = args[InitSdkArg.appId.rawValue] as? String
            else {
                result(FlutterError.invalidArgs("Arguments is invalid"))
                return
            }
            
            let apiVersionArg = args[InitSdkArg.apiVersion.rawValue] as? String
            let permissionsArg = args[InitSdkArg.scope.rawValue] as? [String]
            
            result(FlutterMethodNotImplemented)
        case .getUserId:
            result(getUserId(result: result))
        case .logIn:
            guard
                let args = call.arguments as? [String: Any],
                let permissionsArg = args[LogInArg.scope.rawValue] as? [String]
            else {
                result(FlutterError.invalidArgs("Arguments is invalid"))
                return
            }
            
            logIn(result: result, permissions: permissionsArg)
        case .logOut:
            logOut(result: result)
        case .isLoggedIn:
            result(VKSdk.isLoggedIn)
        case .getUserProfile:
            result(FlutterMethodNotImplemented)
        case .api_method_call:
            result(FlutterMethodNotImplemented)
        case .post_method_call:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func getSdkVersion(result: @escaping FlutterResult) {
        result(VK_SDK_VERSION);
    }
    
    private func getAccessToken(result: @escaping FlutterResult) {
        let token = VKSdk.accessToken()
        result(token?.toMap())
    }
    
    private func getUserId(result: @escaping FlutterResult) {
        let token = VKSdk.accessToken()
        result(token?.userId);
    }
    
    private func logIn(result: @escaping FlutterResult, permissions: [String]) {
        //        _loginDelegate.startLogin(result: result)
        VKSdk.authorize(permissions)
    }
    
    private func logOut(result: @escaping FlutterResult) {
        VKSdk.forceLogout()
        result(nil)
    }
}

extension VKAccessToken {
    func toMap() -> [String: Any?] {
        return [
            "token": accessToken,
            "userId": userId,
            "created": Int64((created).rounded()),
            "email": email,
            "isValid": expiresIn <= 0 || created + Double(expiresIn * 1000) > Date().timeIntervalSince1970,
            "secret": secret,
            "permissions": permissions,
            "httpsRequired": httpsRequired,
            "expiresIn": expiresIn,
        ]
    }
}

extension NSError {
    func isNotConnectedToInternet() -> Bool {
        return domain == NSURLErrorDomain &&
        code == NSURLErrorNotConnectedToInternet
    }
}

extension VKError {
    func toMap() -> [String: Any?] {
        let apiCode: Int?
        let message: String?
        let localizedMessage: String?
        
        if errorCode == VK_API_ERROR, let apiError = self.apiError {
            apiCode = apiError.errorCode
            message = apiError.errorMessage
            localizedMessage = apiError.errorText
        } else {
            apiCode = nil
            message = errorMessage
            localizedMessage = errorText
        }
        
        return [
            "apiCode": apiCode,
            "message": message,
            "localizedMessage": localizedMessage,
        ]
    }
    
    func isCanceled() -> Bool {
        return errorCode == VK_API_CANCELED ||
        errorCode == VK_API_ERROR && errorReason == "user_denied"
    }
}

extension FlutterError {
    static func invalidArgs(_ message: String, details: Any? = nil) -> FlutterError {
        return FlutterError(code: "INVALID_ARGS", message: message, details: details);
    }
    
    static func invalidResult(_ message: String, details: Any? = nil) -> FlutterError {
        return FlutterError(code: "INVALID_RESULT", message: message, details: details);
    }
    
    static func apiUnavailable(_ message: String, details: Any? = nil) -> FlutterError {
        return FlutterError(code: "API_UNAVAILABLE", message: message, details: details);
    }
    
    /// Interrupted. For example by another call.
    static func interrupted(_ message: String, details: Any? = nil) -> FlutterError {
        return FlutterError(code: "INTERRUPTED", message: message, details: details);
    }
    
    /// No connection to Internet.
    static func noConnection(_ message: String, details: Any? = nil) -> FlutterError {
        return FlutterError(code: "NO_CONNECTION", message: message, details: details);
    }
    
    /// Error as result of SDK API call.
    static func apiError(_ message: String, error: VKError) -> FlutterError {
        return FlutterError(code: "API_ERROR", message: message, details: error.toMap());
    }
    
    static func byError(message: String, error: Error?) -> FlutterError {
        if error != nil {
            let nsError = error! as NSError
            if nsError.domain == VKSdkErrorDomain, let vkError = nsError.vkError {
                return FlutterError.apiError(message, error: vkError)
            } else {
                return FlutterError.invalidResult(
                    "\(message). Error: \(nsError)")
            }
        } else {
            return FlutterError.invalidResult("\(message). No error provided.")
        }
    }
}
