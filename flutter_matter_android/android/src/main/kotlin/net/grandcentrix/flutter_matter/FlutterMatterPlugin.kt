package net.grandcentrix.flutter_matter

import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import timber.log.Timber


/** FlutterMatterPlugin */
class FlutterMatterPlugin: FlutterPlugin, ActivityAware, PluginRegistry.ActivityResultListener {

  private var activity: android.app.Activity? = null
  private lateinit var flutterMatterHostApi: FlutterMatterHostApiImpl;

  // FlutterPlugin
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Timber.plant(Timber.DebugTree())

    flutterMatterHostApi = FlutterMatterHostApiImpl()
    FlutterMatterHostApi.setUp(flutterPluginBinding.binaryMessenger, flutterMatterHostApi)
  }

  override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    FlutterMatterHostApi.setUp(flutterPluginBinding.binaryMessenger, null)
  }

  // ActivityAware
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)

    // Initialize Google Matter class with this activity
    flutterMatterHostApi.activity = activity;
    //googleMatter = GoogleMatter(activity!!, methodCallResult)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    activity = null;
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    activity = null;
  }

  // PluginRegistry.ActivityResultListener
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    return flutterMatterHostApi.onActivityResult(requestCode, resultCode, data)
  }
}
