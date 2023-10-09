package net.grandcentrix.flutter_matter.clusters

import chip.devicecontroller.ChipClusters
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import net.grandcentrix.flutter_matter.FlutterError
import net.grandcentrix.flutter_matter.FlutterMatterHostOnOffClusterApi
import net.grandcentrix.flutter_matter.chip.ChipClient
import timber.log.Timber
import java.io.Closeable

class OnOffCluster : FlutterMatterHostOnOffClusterApi, Closeable {

    private lateinit var chipClient: ChipClient

    var activity: android.app.Activity? = null
        set(value) {
            if(value == activity) return
            field = value
            if (value != null) {
                chipClient = ChipClient(value!!)
            }
        }

    private val scope =
        CoroutineScope(Dispatchers.IO + Job())

    private suspend fun getCluster(deviceId: Long, endpointId: Long): ChipClusters.OnOffCluster {
        val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
        return ChipClusters.OnOffCluster(devicePtr, endpointId.toInt())
    }

    override fun off(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit) {
        scope.launch {
            val onOffCluster = getCluster(deviceId, endpointId)

            onOffCluster
                .off(object : ChipClusters.DefaultClusterCallback {
                    override fun onSuccess() {
                        callback(Result.success(Unit))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to send command off")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to send command off"
                                )
                            )
                        )
                    }
                })
        }
    }

    override fun on(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit) {
        scope.launch {
            val onOffCluster = getCluster(deviceId, endpointId)

            onOffCluster
                .on(object : ChipClusters.DefaultClusterCallback {
                    override fun onSuccess() {
                        callback(Result.success(Unit))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to send command on")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to send command on"
                                )
                            )
                        )
                    }
                })
        }
    }

    override fun toggle(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit) {
        scope.launch {
            val onOffCluster = getCluster(deviceId, endpointId)

            onOffCluster
                .toggle(object : ChipClusters.DefaultClusterCallback {
                    override fun onSuccess() {
                        callback(Result.success(Unit))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to send command toggle")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to send command toggle"
                                )
                            )
                        )
                    }
                })
        }
    }

    override fun readOnOff(deviceId: Long, endpointId: Long, callback: (Result<Boolean>) -> Unit) {
        scope.launch {
            val onOffCluster = getCluster(deviceId, endpointId)

            onOffCluster
                .readOnOffAttribute(object : ChipClusters.BooleanAttributeCallback {
                    override fun onSuccess(value: Boolean) {
                        callback(Result.success(value))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to read attribute OnOff")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to read attribute OnOff"
                                )
                            )
                        )
                    }
                })
        }
    }

    override fun close() {
        scope.cancel()
    }
}