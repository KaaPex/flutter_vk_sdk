package kaa.pex.vk_sdk

import com.vk.api.sdk.VKApiJSONResponseParser
import com.vk.api.sdk.VKApiManager
import com.vk.api.sdk.VKMethodCall
import com.vk.api.sdk.internal.ApiCommand
import org.json.JSONException
import org.json.JSONObject

class VKApiCommand(private val method: String, private val args: Map<String, String>?,
                   private val retryCount: Int?, private val skipValidation: Boolean?): ApiCommand<String>() {
    companion object {
        const val RETRY_COUNT = 3
        const val RESPONSE_KEY = "response"
    }

    override fun onExecute(manager: VKApiManager): String {
        val call = VKMethodCall.Builder()
            .method(method)
            .retryCount(retryCount ?: RETRY_COUNT)
            .skipValidation(skipValidation ?: false)
            .version(manager.config.version)

        if (args != null) call.args(args)

        return manager.execute(call.build(), ResponseApiParser())
    }

    private class ResponseApiParser : VKApiJSONResponseParser<String> {
        override fun parse(responseJson: JSONObject): String {
            var data = "{}"
            try {
                data = responseJson.getJSONObject(RESPONSE_KEY).toString()
            } catch(e: JSONException) {
                try {
                    data = responseJson.getJSONArray(RESPONSE_KEY).toString()
                } catch(e: JSONException) {}
            }
            return data
        }
    }
}