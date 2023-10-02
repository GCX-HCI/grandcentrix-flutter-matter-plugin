package net.grandcentrix.flutter_matter.command_handlers

import chip.devicecontroller.ChipClusters
import net.grandcentrix.flutter_matter.Command
import net.grandcentrix.flutter_matter.chip.ChipClient
import timber.log.Timber
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

class OnOffClusterHandler(private val chipClient: ChipClient) : ICommandHandler {

    override suspend fun handle(
        deviceId: Long,
        endpointId: Long,
        command: Command
    ) {
        val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
        val onOffCluster = ChipClusters.OnOffCluster(devicePtr, endpointId.toInt())

        when (command) {
            Command.OFF -> off(onOffCluster)
            Command.ON -> on(onOffCluster)
            Command.TOGGLE -> toggle(onOffCluster)
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
}