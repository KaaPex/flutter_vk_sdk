package kaa.pex.vk_sdk

import android.content.Context
import android.content.pm.PackageManager
import android.util.Log
import androidx.activity.result.ActivityResultLauncher
import androidx.annotation.NonNull
import androidx.appcompat.app.AppCompatActivity
import com.vk.api.sdk.VK
import com.vk.api.sdk.VKApiCallback
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
class VkSdkPlugin() : FlutterPlugin, MethodCallHandler, ActivityAware, AppCompatActivity() {
  companion object {
    private const val getPlatformVersion = "getPlatformVersion"
    private const val getSdkVersion = "getSdkVersion"
    private const val initSdk = "initSdk"
    private const val login = "logIn"
    private const val logout = "logOut"
    private const val scopeArg = "scope"
  }

  private lateinit var context: Context
  private lateinit var loginCallback: LoginCallback
  private lateinit var authLauncher: ActivityResultLauncher<Collection<VKScope>>
  private var activityPluginBinding: ActivityPluginBinding? = null

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  init {
    Log.d("VK SDK PLUGIN", "_________________________INIT")
  }

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "vk_sdk")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext

    this.loginCallback = LoginCallback()
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
      getPlatformVersion -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      getSdkVersion -> {
        sendResult(getSdkVersion(), result)
      }
      initSdk -> {
        val initScope = call.argument<List<String>?>(scopeArg)
        initSdk(initScope, result)
      }
      login -> {
        val scope = call.argument<List<String>>(scopeArg) ?: listOf()
        logIn(scope, result)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
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
    loginCallback.addPending(result)
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
    VK.login(activityPluginBinding?.activity!!, vkScopes)
//    authLauncher = VK.login(activityPluginBinding!!.activity, loginCallback)
//    authLauncher.launch(vkScopes)
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
    this.activityPluginBinding = activityPluginBinding
  }

  private fun resetActivity() {
    activityPluginBinding = null
  }

  private fun sendResult(data: Any?, @NonNull r: Result) {
    r.success(data)
  }

  private fun sendError(error: FlutterError,  @NonNull r: Result) {
    r.error(error.code, error.message, error.details)
  }
}
