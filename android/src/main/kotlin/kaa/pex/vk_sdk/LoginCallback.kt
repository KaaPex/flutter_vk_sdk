package kaa.pex.vk_sdk

import com.vk.api.sdk.auth.VKAccessToken
import com.vk.api.sdk.auth.VKAuthCallback
import com.vk.api.sdk.auth.VKAuthenticationResult
import com.vk.api.sdk.exceptions.VKAuthException

import io.flutter.plugin.common.MethodChannel.Result

class LoginCallback : VKAuthCallback {
    private var pendingResult: Result? = null

    fun addPending(result: Result) {
        if (pendingResult != null) {
            callError(FlutterError.interrupted("Interrupted by another login call"))
        }
        pendingResult = result
    }

    override fun onLogin(token: VKAccessToken) {
        callResult(Results.loginSuccess(token))
    }

    override fun onLoginFailed(authException: VKAuthException) {
        if (authException.isCanceled) {
            callResult(Results.loginCancelled())
        } else {
            val errorCode = authException.webViewError
            callError(FlutterError.apiError("Login failed: $errorCode",
                VKError(errorCode, authException.authError)))
        }
    }

    private fun callResult(data: HashMap<String, Any>) {
        pendingResult?.success(data)
        pendingResult = null
    }

    private fun callError(error: FlutterError) {
        pendingResult?.error(error.code, error.message, error.details)
        pendingResult = null
    }

//    override fun onActivityResult(result: VKAuthenticationResult?) {
//        when (result) {
//            is VKAuthenticationResult.Success -> onLogin(result.token)
//            is VKAuthenticationResult.Failed -> onLoginFailed(result.exception)
//        }
//    }
}