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
    
    private lazy var _uiDelegate = VkUIDelegate()
    private lazy var _pluginDelegate = VkSdkPluginDelegate()
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
            else {
                result(FlutterError.invalidArgs("Arguments is invalid"))
                return
            }
            
            let permissionsArg = args[InitSdkArg.scope.rawValue] as? [String]

             guard
                let appId = Bundle.main.object(forInfoDictionaryKey: "VKAppId") as? String
                else {
                    result(FlutterError.invalidArgs("App ID is not found. Please add VKAppId parameter in Info.plist"))
                    return
            }
            
            initSdk(result: result, appId: appId, permissions: permissionsArg)
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
        case .api_method_call:
            _pluginDelegate.apiMethodCall(arguments: call.arguments, result: result)
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

    private func initSdk(result: @escaping FlutterResult, appId: String, permissions: [String]?) {
        if let prevSdk = _sdk {
            if prevSdk.currentAppId == appId {
                result(true)
                return
            }

            prevSdk.unregisterDelegate(_pluginDelegate)
            prevSdk.uiDelegate = nil
        }

         let sdk = VKSdk.initialize(withAppId: appId)!

         _sdk = sdk

         sdk.uiDelegate = _uiDelegate
         sdk.register(_pluginDelegate)

         VKSdk.wakeUpSession(permissions) { state, error in
             switch state {
             case .initialized, .authorized:
                 result(true)
             case .pending, .external, .safariInApp, .webview:
                 // Initialization complete, but log in still in progress
                 self._pluginDelegate.waitForInit(result: result)
             case .unknown, .error:
                 result(FlutterError.byError(
                     message: "Init failed. State: \(state)", error: error))
             @unknown default:
                 result(FlutterError.byError(
                     message: "Init failed with unhandled state: \(state)", error: error))
             }
         }

         result(true)
    }
    
    private func getUserId(result: @escaping FlutterResult) {
        let token = VKSdk.accessToken()
        result(token?.userId);
    }
    
    private func logIn(result: @escaping FlutterResult, permissions: [String]) {
        _pluginDelegate.startLogin(result: result)
        VKSdk.authorize(permissions)
    }
    
    private func logOut(result: @escaping FlutterResult) {
        VKSdk.forceLogout()
        result(nil)
    }
}

class VKAPIRequest {
    var method: String
    var url: String?
    var parameters: [String: String]
    var retryCount: Int32?

    init(method: String, parameters: [String: String]?, retryCount: Int32? = 3) {
        self.method = method
        self.parameters = parameters ?? [:]
        self.retryCount = retryCount
    }

    func request(completeBlock: @escaping (_ vkResponse: VKResponse<VKApiObject>?) -> Void, errorBlock: @escaping (Error?) -> Void) {
        let newRequest: VKRequest = VKRequest(method: self.method, parameters: self.parameters)
        newRequest.parseModel = false
        newRequest.requestTimeout = 25
        if let attempts = retryCount {
            newRequest.attempts = attempts
        }
        newRequest.execute(resultBlock: completeBlock, errorBlock: errorBlock)
    }
}

class VkUIDelegate : NSObject, VKSdkUIDelegate {
    private var rootViewController: UIViewController? {
        get {
            let app = UIApplication.shared
            return app.delegate?.window??.rootViewController
        }
    }

    func vkSdkShouldPresent(_ controller: UIViewController!) {
        guard let vc = rootViewController else {
            // TODO: log error
            return
        }

        vc.present(controller, animated: true)
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        guard let vc = rootViewController else {
            // TODO: log error
            return
        }

        let controller = VKCaptchaViewController.captchaControllerWithError(captchaError)!
        controller.present(in: vc)
    }
}

class VkSdkPluginDelegate : NSObject, VKSdkDelegate {
    private var _pendingLoginResult: FlutterResult?
    private var _pendingInitResult: FlutterResult?

    func waitForInit(result: @escaping FlutterResult) {
        if let prevResult = _pendingInitResult {
            prevResult(FlutterError.interrupted("Interrupted by another init call"))
        }

        _pendingInitResult = result
    }

    func startLogin(result: @escaping FlutterResult) {
        if let prevResult = _pendingLoginResult {
            prevResult(FlutterError.interrupted("Interrupted by another login call"))
        }

        _pendingLoginResult = result
    }

    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if let pendingResult = _pendingLoginResult {
            _pendingLoginResult = nil
            let response: Any

            if let token = result.token {
                response = [
                    "accessToken": token.toMap()
                ]
            } else if let error = result.error {
                let nsError = error as NSError
                if nsError.domain == VKSdkErrorDomain, let vkError = nsError.vkError {
                    if vkError.isCanceled() {
                        response = [
                            "isCanceled": true
                        ]
                    } else {
                        response = FlutterError.apiError(
                            "Login failed: \(vkError.errorMessage ?? "nil")",
                            error: vkError)
                    }
                } else if nsError.isNotConnectedToInternet() {
                    response = FlutterError.noConnection(
                        "Login failed: not connected to Internet.")
                } else {
                    response = FlutterError.invalidResult(
                        "Invalid login error: \(String(describing: error))")
                }
            } else {
                response = FlutterError.invalidResult(
                    "Invalid login result: \(String(describing: result))")
            }

            pendingResult(response)
        } else if let pendingResult = _pendingInitResult {
            // it's auto auth from wakeUpSession(), without authorize() call

            // We don't need result here, just a fact that it's done
            _pendingInitResult = nil
            pendingResult(true)
        }
    }

    func apiMethodCall(arguments: Any?, result: @escaping FlutterResult) {
        guard let methodName = getArgument("method", from: arguments) as String? else {
            return result(FlutterError(code: "VK API DELEGATE", message: "___________________ERROR: NO METHOD PASSED", details: nil))
        }

        print("VK API DELEGATE", "___________________METHOD: \(methodName)")

        let args: Dictionary<String, String>? = getArgument("arguments", from: arguments)
        let retryCount: Int32? = getArgument("retry_count", from: arguments)

        VKAPIRequest(method: methodName, parameters: args, retryCount: retryCount).request(
            completeBlock: { vkResult in
                print("VK API DELEGATE", "___________________SUCCESS: \(vkResult?.responseString)")
                result(vkResult?.responseString ?? "")
            },
            errorBlock: { error in
                // TODO : common error handler
                print("VK API DELEGATE", "___________________ERROR: \(error.debugDescription)")
                result(FlutterError.apiError(message: "Method \(methodName) call error \(error.debugDescription)", error: error))
            }
        )
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
