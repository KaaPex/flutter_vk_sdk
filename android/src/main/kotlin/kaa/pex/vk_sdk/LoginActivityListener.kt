package kaa.pex.vk_sdk

import android.content.Intent
import com.vk.api.sdk.VK
import io.flutter.plugin.common.PluginRegistry

class LoginActivityListener(private val loginCallback: LoginCallback) :
    PluginRegistry.ActivityResultListener {
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        @Suppress("DEPRECATION")
        return VK.onActivityResult(requestCode, resultCode, data, loginCallback)
    }
}