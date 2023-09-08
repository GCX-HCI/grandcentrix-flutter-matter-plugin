package net.grandcentrix.flutter_matter

import io.flutter.embedding.engine.plugins.FlutterPlugin

class FlutterMatterHostApiImpl : FlutterMatterHostApi {
  override fun getPlatformVersion(callback: (Result<String>) -> Unit) {
    callback(Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
  }
}

/** FlutterMatterPlugin */
class FlutterMatterPlugin: FlutterPlugin {
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    var flutterMatterHostApi = FlutterMatterHostApiImpl()
    FlutterMatterHostApi.setUp(flutterPluginBinding.binaryMessenger, flutterMatterHostApi)
  }

  override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    FlutterMatterHostApi.setUp(flutterPluginBinding.binaryMessenger, null)
  }
}
