package kaa.pex.vk_sdk

import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
//import androidx.activity.result.ActivityResultLauncher
import androidx.annotation.NonNull
import com.vk.api.sdk.*
import com.vk.api.sdk.auth.VKAccessToken
import com.vk.api.sdk.auth.VKScope
import com.vk.sdk.api.account.AccountService

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*

/** VkSdkPlugin */
class VkSdkPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  companion object {
    private const val GET_PLATFORM_VERSION = "getPlatformVersion"
    private const val GET_SDK_VERSION = "getSdkVersion"
    private const val GET_ACCESS_TOKEN = "getAccessToken"
    private const val GET_USER_ID = "getUserId"
    private const val INIT_SDK = "initSdk"
    private const val LOGIN = "logIn"
    private const val LOGOUT = "logOut"
    private const val API_METHOD_CALL = "api_method_call"
    private const val POST_METHOD_CALL = "post_method_call"
    private const val SCOPE_ARG = "scope"
  }

  private lateinit var context: Context
  private var loginActivityListener: LoginActivityListener? = null
  private var loginCallback: LoginCallback? = null
//  private lateinit var authLauncher: ActivityResultLauncher<Collection<VKScope>>
  private var activityPluginBinding: ActivityPluginBinding? = null
  private var activity: Activity? = null

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vk_sdk")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
    loginCallback = LoginCallback()
    loginActivityListener = LoginActivityListener(loginCallback!!)
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    loginCallback = null
    loginActivityListener = null
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    setActivity(binding)
  }

  override fun onDetachedFromActivity() {
    resetActivity()
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    setActivity(binding)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    resetActivity()
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.d("VK SDK PLUGIN", "_________________________CALL METHOD: ${call.method}")
    when (call.method) {
      GET_PLATFORM_VERSION -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      GET_SDK_VERSION -> {
        sendResult(getSdkVersion(), result)
      }
      GET_ACCESS_TOKEN -> {
        sendResult(getAccessToken(), result)
      }
      GET_USER_ID -> {
        sendResult(getUserId(), result)
      }
      INIT_SDK -> {
        val initScope = call.argument<List<String>?>(SCOPE_ARG)
        initSdk(initScope, result)
      }
      LOGIN -> {
        val scope = call.argument<List<String>>(SCOPE_ARG) ?: listOf()
        logIn(scope, result)
      }
      LOGOUT -> {
        logOut()
      }
      API_METHOD_CALL -> {
        val arguments = call.arguments<Map<String, Any?>>()
        apiMethodCall(arguments, result)
      }
      POST_METHOD_CALL -> {
        result.notImplemented()
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  private fun getSdkVersion(): String {
      val metaData = context.packageManager?.getApplicationInfo(
        context.packageName, PackageManager.GET_META_DATA
      )
    if (metaData != null) {
      return metaData.metaData["VKSdkVersion"].toString()
    }
    return ""
  }

  private fun getAccessToken(): HashMap<String, Any?>? {
    if (VK.isLoggedIn()) {
      val storage = VKPreferencesKeyValueStorage(context)
      val token = VKAccessToken.restore(storage)

      if (token != null) {
        return Results.accessToken(token)
      }
    }

    return null
  }

  private fun getUserId(): String? {
    if (VK.isLoggedIn()) {
      return VK.getUserId().toString()
    }
    return null
  }

  private fun initSdk(scope: List<String>?, @NonNull channelResult: Result) {
    VK.initialize(context)
    if (scope != null && VK.isLoggedIn()) {
      val userId = VK.getUserId()
      VK.execute(AccountService().accountGetAppPermissions(userId), object : VKApiCallback<Int> {
        override fun success(result: Int) {
          val list = listOf(*scope.toTypedArray())
          val vkScopes: List<VKScope> = getScopes(list)
          if (!VKClient.hasScopes(vkScopes, result)) {
            VK.logout()
          }
          sendResult(true, channelResult)
        }

        override fun fail(error: Exception) {
          sendError(FlutterError.apiError("Get profile permissions error: " + error.message,
            VKError(0, error.message.toString())), channelResult)
        }
      })
    } else {
      sendResult(true, channelResult)
    }
  }

  private fun logIn(scopes: List<String>, @NonNull result: Result) {
    loginCallback?.addPending(result)
    val list = listOf(*scopes.toTypedArray())
    val vkScopes: List<VKScope> = getScopes(list)
    // TODO: use ActivityResultLauncher
    // There are multiple problems with this new login approach:
    // 1. It's requires ComponentActivity, so FlutterActivity is not applicable
    // 2. We need register login activity at start of the app.
    // Which is not crucial but looks pretty bad.
    // 3. Even using FlutterFragmentActivity, we get error
    // "It's requires ComponentActivity, so FlutterActivity is not applicable" on launch
    @Suppress("DEPRECATION")
    VK.login(activity!!, vkScopes)
//    authLauncher = VK.login(activityPluginBinding!!.activity, loginCallback)
//    authLauncher.launch(vkScopes)
  }

  private fun logOut() {
    VK.logout()
  }

  private fun apiMethodCall(arguments: Map<String, Any?>, @NonNull _result: Result) {
    val methodName: String = arguments["method"] as String
    Log.d("VK SDK PLUGIN", "___________________METHOD: $methodName")

    var args: Map<String, String>? = null
    if (arguments.containsKey("arguments")) {
      args = arguments["arguments"] as Map<String, String>
    }

    var retryCount: Int? = null
    if (arguments.containsKey("retry_count")) {
      retryCount = arguments["retry_count"] as Int
    }

    var skipValidation: Boolean? = null
    if (arguments.containsKey("skip_validation")) {
      skipValidation = arguments["skip_validation"] as Boolean
    }

    val command = VKApiCommand(methodName, args, retryCount, skipValidation)
    VK.execute(command, object : VKApiCallback<String?> {
      override fun success(result: String?) {
        if (result != null) {
          sendResult(result, _result)
        } else {
          sendError(FlutterError.invalidResult("The result is null"), _result)
        }
      }

      override fun fail(error: Exception) {
        sendError(FlutterError.apiError("Get profile error: " + error.message,
          VKError(0, error.message.toString())), _result)
      }
    })
  }

  private fun getScopes(list: List<String>): List<VKScope> {
    val vkScopes: MutableList<VKScope> = ArrayList()
    val count = list.size
    for (i in 0 until count) {
      val item = list[i]
      val scope = VKScope.valueOf(item.uppercase(Locale.getDefault()))
      vkScopes.add(scope)
    }
    return vkScopes
  }

  private fun setActivity(activityPluginBinding: ActivityPluginBinding) {
    activityPluginBinding.addActivityResultListener(loginActivityListener!!)
    this.activityPluginBinding = activityPluginBinding
    activity = activityPluginBinding.activity
  }

  private fun resetActivity() {
    activityPluginBinding?.removeActivityResultListener(loginActivityListener!!)
    activityPluginBinding = null
    activity = null
  }

  private fun sendResult(data: Any?, @NonNull r: Result) {
    r.success(data)
  }

  private fun sendError(error: FlutterError,  @NonNull r: Result) {
    r.error(error.code, error.message, error.details)
  }
}
