import '../../vk_sdk.dart';

class VKApi {
  VKMethodCall createMethodCall(String? method) {
    assert(method?.isNotEmpty == true);
    return VKMethodCall(method!);
  }
}
