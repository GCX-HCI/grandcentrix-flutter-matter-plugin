package net.grandcentrix.flutter_matter.clusters

import chip.devicecontroller.ChipClusters
import net.grandcentrix.flutter_matter.Attribute
import net.grandcentrix.flutter_matter.Command
import net.grandcentrix.flutter_matter.chip.ChipClient
import net.grandcentrix.flutter_matter.interfaces.*
import timber.log.Timber
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class OnOffCluster(private val chipClient: ChipClient) : ICommandHandler, IAttributeHandler {

    override suspend fun handle(
        deviceId: Long,
        endpointId: Long,
        command: Command
    ) {
        val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
        val onOffCluster = ChipClusters.OnOffCluster(devicePtr, endpointId.toInt())

        @Suppress("REDUNDANT_ELSE_IN_WHEN")
        when (command) {
            Command.OFF -> off(onOffCluster)
            Command.ON -> on(onOffCluster)
            Command.TOGGLE -> toggle(onOffCluster)
            else -> throw NotImplementedError()
        }
    }

    private suspend fun off(cluster: ChipClusters.OnOffCluster) {
        return suspendCoroutine { continuation ->
            cluster
                .off(
                    object : ChipClusters.DefaultClusterCallback {
                        override fun onSuccess() {
                            continuation.resume(Unit)
                        }

                        override fun onError(ex: Exception) {
                            Timber.e(ex, "off command failure")
                            continuation.resumeWithException(ex)
                        }
                    })
        }
    }

    private suspend fun on(cluster: ChipClusters.OnOffCluster) {
        return suspendCoroutine { continuation ->
            cluster
                .on(
                    object : ChipClusters.DefaultClusterCallback {
                        override fun onSuccess() {
                            continuation.resume(Unit)
                        }

                        override fun onError(ex: Exception) {
                            Timber.e(ex, "on command failure")
                            continuation.resumeWithException(ex)
                        }
                    })
        }
    }

    private suspend fun toggle(cluster: ChipClusters.OnOffCluster) {
        return suspendCoroutine { continuation ->
            cluster
                .toggle(
                    object : ChipClusters.DefaultClusterCallback {
                        override fun onSuccess() {
                            continuation.resume(Unit)
                        }

                        override fun onError(ex: Exception) {
                            Timber.e(ex, "toggle command failure")
                            continuation.resumeWithException(ex)
                        }
                    })
        }
    }

    override suspend fun handle(deviceId: Long, endpointId: Long, attribute: Attribute): Any {
        val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
        val onOffCluster = ChipClusters.OnOffCluster(devicePtr, endpointId.toInt())

        return when (attribute) {
            Attribute.ONOFF -> readOnOff(onOffCluster)
            else -> throw NotImplementedError()
        }
    }

    private suspend fun readOnOff(cluster: ChipClusters.OnOffCluster): Boolean {
        return suspendCoroutine { continuation ->
            cluster
                .readOnOffAttribute(
                    object : ChipClusters.BooleanAttributeCallback {
                        override fun onSuccess(value: Boolean) {
                            continuation.resume(value)
                        }

                        override fun onError(ex: Exception) {
                            Timber.e(ex, "readOnOffAttribute failure")
                            continuation.resumeWithException(ex)
                        }
                    })
        }
    }
}