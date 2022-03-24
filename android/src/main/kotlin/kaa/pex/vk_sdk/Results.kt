package kaa.pex.vk_sdk

import com.vk.api.sdk.auth.VKAccessToken
import org.json.JSONArray

object Results {
    fun loginCancelled(): HashMap<String, Any> {
        return hashMapOf("isCanceled" to true)
    }

    fun accessToken(accessToken: VKAccessToken): HashMap<String, Any?> {
        return hashMapOf(
            "token" to accessToken.accessToken,
            "userId" to accessToken.userId.toString(),
            "created" to accessToken.created,
            "email" to accessToken.email,
            "isValid" to accessToken.isValid,
            "secret" to accessToken.secret,
            "phone" to accessToken.phone,
            "phoneAccessKey" to accessToken.phoneAccessKey,
        )
    }

    fun loginSuccess(accessToken: VKAccessToken): HashMap<String, Any> {
        return hashMapOf("accessToken" to accessToken(accessToken))
    }

    fun error(error: VKError): HashMap<String, Any?> {
        return hashMapOf(
            "apiCode" to error.errorCode,
            "message" to error.errorMsg
        )
    }
}