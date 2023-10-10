package net.grandcentrix.flutter_matter

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry
import net.grandcentrix.flutter_matter.clusters.DescriptorCluster
import net.grandcentrix.flutter_matter.clusters.OnOffCluster
import timber.log.Timber


/** FlutterMatterPlugin */
class FlutterMatterPlugin: FlutterPlugin, ActivityAware, PluginRegistry.ActivityResultListener {
  private lateinit var flutterMatterHostApi: FlutterMatterHostApiImpl
  private lateinit var descriptorClusterApi: DescriptorCluster
  private lateinit var onOffClusterApi: OnOffCluster

  private fun setActivity(activity: Activity?) {
    flutterMatterHostApi.activity = activity
    descriptorClusterApi.activity = activity
    onOffClusterApi.activity = activity
  }

  // FlutterPlugin
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    Timber.plant(Timber.DebugTree())

    flutterMatterHostApi = FlutterMatterHostApiImpl()
    descriptorClusterApi = DescriptorCluster()
    val flutterOnOffClusterApi =  FlutterMatterFlutterOnOffClusterApi(flutterPluginBinding.binaryMessenger)
    onOffClusterApi = OnOffCluster(flutterOnOffClusterApi)

    if(flutterPluginBinding.applicationContext is Activity) {
      setActivity(flutterPluginBinding.applicationContext as Activity)
    }

    FlutterMatterHostApi.setUp(flutterPluginBinding.binaryMessenger, flutterMatterHostApi)
    FlutterMatterHostDescriptorClusterApi.setUp(flutterPluginBinding.binaryMessenger, descriptorClusterApi)
    FlutterMatterHostOnOffClusterApi.setUp(flutterPluginBinding.binaryMessenger, onOffClusterApi)
  }

  override fun onDetachedFromEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    flutterMatterHostApi.close()
    descriptorClusterApi.close()
    onOffClusterApi.close()

    FlutterMatterHostApi.setUp(flutterPluginBinding.binaryMessenger, null)
  }

  // ActivityAware
  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    setActivity(binding.activity)
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {
    setActivity(null)
  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    setActivity(binding.activity)
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivity() {
    setActivity(null);
  }

  // PluginRegistry.ActivityResultListener
  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
    return flutterMatterHostApi.onActivityResult(requestCode, resultCode, data)
  }
}
