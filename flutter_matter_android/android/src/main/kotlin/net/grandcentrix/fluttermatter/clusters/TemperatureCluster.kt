package net.grandcentrix.fluttermatter.clusters

import chip.devicecontroller.ChipClusters
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import net.grandcentrix.fluttermatter.FlutterError
import net.grandcentrix.fluttermatter.FlutterMatterHostTemperatureClusterApi
import net.grandcentrix.fluttermatter.chip.ChipClient
import timber.log.Timber
import java.io.Closeable

class TemperatureCluster : FlutterMatterHostTemperatureClusterApi, Closeable {
    private lateinit var chipClient: ChipClient

    var activity: android.app.Activity? = null
        set(value) {
            if (value == activity) return
            field = value
            if (value != null) {
                chipClient = ChipClient(value!!)
            }
        }

    private suspend fun getCluster(
        deviceId: Long,
        endpointId: Long,
    ): ChipClusters.TemperatureMeasurementCluster {
        val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
        return ChipClusters.TemperatureMeasurementCluster(devicePtr, endpointId.toInt())
    }

    private val scope =
        CoroutineScope(Dispatchers.IO + Job())

    override fun readMeasuredValue(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<Long?>) -> Unit,
    ) {
        scope.launch {
            val cluster =
                try {
                    getCluster(deviceId, endpointId)
                } catch (e: Exception) {
                    callback(Result.failure(FlutterError("-1", "Can't connect to device!")))
                    null
                }

            cluster?.readMeasuredValueAttribute(
                object :
                    ChipClusters.TemperatureMeasurementCluster.MeasuredValueAttributeCallback {
                    override fun onSuccess(value: Int?) {
                        callback(Result.success(value?.toLong()))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to read attribute MeasuredValue")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to read attribute MeasuredValue",
                                ),
                            ),
                        )
                    }
                },
            )
        }
    }

    override fun readMinMeasuredValue(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<Long?>) -> Unit,
    ) {
        scope.launch {
            val cluster =
                try {
                    getCluster(deviceId, endpointId)
                } catch (e: Exception) {
                    callback(Result.failure(FlutterError("-1", "Can't connect to device!")))
                    null
                }

            cluster?.readMinMeasuredValueAttribute(
                object :
                    ChipClusters.TemperatureMeasurementCluster.MinMeasuredValueAttributeCallback {
                    override fun onSuccess(value: Int?) {
                        callback(Result.success(value?.toLong()))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to read attribute MinMeasuredValue")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to read attribute MinMeasuredValue",
                                ),
                            ),
                        )
                    }
                },
            )
        }
    }

    override fun readMaxMeasuredValue(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<Long?>) -> Unit,
    ) {
        scope.launch {
            val cluster =
                try {
                    getCluster(deviceId, endpointId)
                } catch (e: Exception) {
                    callback(Result.failure(FlutterError("-1", "Can't connect to device!")))
                    null
                }

            cluster?.readMaxMeasuredValueAttribute(
                object :
                    ChipClusters.TemperatureMeasurementCluster.MaxMeasuredValueAttributeCallback {
                    override fun onSuccess(value: Int?) {
                        callback(Result.success(value?.toLong()))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to read attribute MaxMeasuredValue")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to read attribute MaxMeasuredValue",
                                ),
                            ),
                        )
                    }
                },
            )
        }
    }

    override fun readTolerance(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<Long?>) -> Unit,
    ) {
        scope.launch {
            val cluster =
                try {
                    getCluster(deviceId, endpointId)
                } catch (e: Exception) {
                    callback(Result.failure(FlutterError("-1", "Can't connect to device!")))
                    null
                }

            cluster?.readToleranceAttribute(
                object :
                    ChipClusters.IntegerAttributeCallback {
                    override fun onSuccess(value: Int) {
                        callback(Result.success(value.toLong()))
                    }

                    override fun onError(ex: Exception) {
                        Timber.e(ex, "Failed to read attribute Tolerance")
                        callback(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to read attribute Tolerance",
                                ),
                            ),
                        )
                    }
                },
            )
        }
    }

    override fun close() {
        scope.cancel()
    }
}
