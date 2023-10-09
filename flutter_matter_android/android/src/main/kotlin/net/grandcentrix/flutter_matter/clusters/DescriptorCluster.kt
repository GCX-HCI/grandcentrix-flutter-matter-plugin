package net.grandcentrix.flutter_matter.clusters

import chip.devicecontroller.ChipClusters
import chip.devicecontroller.ChipStructs
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import net.grandcentrix.flutter_matter.DescriptorClusterDeviceTypeStruct
import net.grandcentrix.flutter_matter.FlutterError
import net.grandcentrix.flutter_matter.FlutterMatterHostDescriptorClusterApi
import net.grandcentrix.flutter_matter.chip.ChipClient
import timber.log.Timber
import java.io.Closeable

class DescriptorCluster:
    FlutterMatterHostDescriptorClusterApi, Closeable {

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

    private suspend fun getCluster(deviceId: Long, endpointId: Long): ChipClusters.DescriptorCluster {
        val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
        return ChipClusters.DescriptorCluster(devicePtr, endpointId.toInt())
    }

    override fun readDeviceTypeList(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<List<DescriptorClusterDeviceTypeStruct>>) -> Unit
    ) {
        scope.launch {
            val cluster = getCluster(deviceId, endpointId)

            cluster.readDeviceTypeListAttribute(object :
                ChipClusters.DescriptorCluster.DeviceTypeListAttributeCallback {
                override fun onSuccess(valueList: MutableList<ChipStructs.DescriptorClusterDeviceTypeStruct>?) {
                    callback(Result.success(valueList?.map { x ->
                        DescriptorClusterDeviceTypeStruct(
                            x.deviceType,
                            x.revision.toLong()
                        )
                    } ?: listOf()))
                }

                override fun onError(ex: Exception) {
                    Timber.e(ex, "Failed to read attribute DeviceTypeList")
                    callback(
                        Result.failure(
                            FlutterError(
                                "-1",
                                "Failed to read attribute DeviceTypeList"
                            )
                        )
                    )
                }
            })
        }
    }

    override fun readServerList(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<List<Long>>) -> Unit
    ) {
        scope.launch {
            val cluster = getCluster(deviceId, endpointId)

            cluster.readServerListAttribute(object :
                ChipClusters.DescriptorCluster.ServerListAttributeCallback {

                override fun onSuccess(valueList: MutableList<Long>?) {
                    callback(Result.success(valueList ?: listOf()))
                }

                override fun onError(ex: Exception) {
                    Timber.e(ex, "Failed to read attribute ServerList")
                    callback(
                        Result.failure(
                            FlutterError(
                                "-1",
                                "Failed to read attribute ServerList"
                            )
                        )
                    )
                }
            })
        }
    }

    override fun readClientList(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<List<Long>>) -> Unit
    ) {
        scope.launch {
            val cluster = getCluster(deviceId, endpointId)

            cluster.readClientListAttribute(object :
                ChipClusters.DescriptorCluster.ClientListAttributeCallback {

                override fun onSuccess(valueList: MutableList<Long>?) {
                    callback(Result.success(valueList ?: listOf()))
                }

                override fun onError(ex: Exception) {
                    Timber.e(ex, "Failed to read attribute ClientList")
                    callback(
                        Result.failure(
                            FlutterError(
                                "-1",
                                "Failed to read attribute ClientList"
                            )
                        )
                    )
                }
            })
        }
    }

    override fun readPartsList(
        deviceId: Long,
        endpointId: Long,
        callback: (Result<List<Long>>) -> Unit
    ) {
        scope.launch {
            val cluster = getCluster(deviceId, endpointId)

            cluster.readPartsListAttribute(object :
                ChipClusters.DescriptorCluster.PartsListAttributeCallback {

                override fun onSuccess(valueList: MutableList<Int>?) {
                    callback(Result.success(valueList?.map { x -> x.toLong() } ?: listOf()))
                }

                override fun onError(ex: Exception) {
                    Timber.e(ex, "Failed to read attribute PartsList")
                    callback(
                        Result.failure(
                            FlutterError(
                                "-1",
                                "Failed to read attribute PartsList"
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