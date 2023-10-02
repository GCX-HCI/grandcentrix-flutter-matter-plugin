package net.grandcentrix.flutter_matter

import android.content.ComponentName
import android.content.Intent
import com.google.android.gms.home.matter.Matter
import com.google.android.gms.home.matter.commissioning.CommissioningRequest
import com.google.android.gms.home.matter.commissioning.CommissioningResult
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import net.grandcentrix.flutter_matter.chip.ChipClient
import net.grandcentrix.flutter_matter.command_handlers.ICommandHandler
import net.grandcentrix.flutter_matter.command_handlers.OnOffClusterHandler
import net.grandcentrix.flutter_matter.commissioning.AppCommissioningService
import timber.log.Timber
import java.io.Closeable

class FlutterMatterHostApiImpl : FlutterMatterHostApi, Closeable {
    var activity: android.app.Activity? = null
    private var callback: ((Result<MatterDevice>) -> Unit)? = null

    private val scope =
        CoroutineScope(Dispatchers.IO + Job())

    /* 0xFFF4 is a test vendor ID, replace with your assigned company ID */
    private val VENDOR_ID = 0xFFF4

    // FlutterMatterHostApi
    override fun getPlatformVersion(callback: (Result<String>) -> Unit) {
        callback(Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
    }

    override fun commission(request: CommissionRequest, callback: (Result<MatterDevice>) -> Unit) {
        Timber.d("CommissionDevice: starting")
        val commissioningRequest = CommissioningRequest.builder()
            .setCommissioningService(ComponentName(activity!!, AppCommissioningService::class.java))
            .build()

        AppCommissioningService.deviceId = request.id

        // The call to commissionDevice() creates the IntentSender that will eventually be launched
        // in the fragment to trigger the commissioning activity in GPS.
        Matter.getCommissioningClient(activity!!)
            .commissionDevice(commissioningRequest)
            .addOnSuccessListener { result ->
                Timber.d("ShareDevice: Success getting the IntentSender: result [${result}]")
                this.callback = callback
                activity!!.startIntentSenderForResult(
                    result,
                    1001,
                    Intent(),
                    Integer.valueOf(0),
                    Integer.valueOf(0),
                    Integer.valueOf(0),
                    null
                )
            }
            .addOnFailureListener { error ->
                Timber.e(error)
                callback(Result.failure(error))
            }
    }

    override fun command(
        deviceId: Long,
        endpointId: Long,
        cluster: Cluster,
        command: Command,
        callback: (Result<Unit>) -> Unit
    ) {
        val chipClient = ChipClient(activity!!)

        @Suppress("REDUNDANT_ELSE_IN_WHEN")
        val handler: ICommandHandler =
            when (cluster) {
                Cluster.ONOFF ->
                    OnOffClusterHandler(chipClient)

                else -> {
                    callback(Result.failure(NotImplementedError()))
                    return
                }
            }

        scope.launch {
            try {
                handler.handle(deviceId, endpointId, command)
            } catch (e: Exception) {
                callback(Result.failure(e))
            }
        }
    }

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (resultCode) {
            null -> {
                Timber.e("Timed out!")
                callback!!(Result.failure(FlutterError("1", "timeout", "Timed out!")))
            }

            android.app.Activity.RESULT_OK -> {
                // Proceed to get this device's details
                if (data != null) {
                    // Get the Device Data and send it back
                    val result: CommissioningResult =
                        CommissioningResult.fromIntentSenderResult(
                            resultCode,
                            data
                        )
                    print("Commissioned Device data: $result")

                    val commissionedDevice: HashMap<String, Any> = HashMap()
                    if (result.token == null) {
                        Timber.e("No token in response!")
                        callback!!(
                            Result.failure(
                                FlutterError(
                                    "2",
                                    "token",
                                    "Failed to get token"
                                )
                            )
                        )
                        return false
                    } else {
                        commissionedDevice["deviceId"] = result.token?.toLong()!!
                    }
                    commissionedDevice["deviceName"] = result.deviceName
                    commissionedDevice["deviceType"] =
                        result.commissionedDeviceDescriptor.deviceType
                    commissionedDevice["vendorId"] = result.commissionedDeviceDescriptor.vendorId
                    commissionedDevice["describeContents"] =
                        result.commissionedDeviceDescriptor.describeContents()

                    callback!!(Result.success(MatterDevice(result.token?.toLong()!!)))
                }
            }

            else -> {
                Timber.e("User cancelled!")
                callback!!(Result.failure(FlutterError("0", "User Cancelled", "User Cancelled")))
            }
        }

        return resultCode == android.app.Activity.RESULT_OK
    }

    override fun close() {
        scope.cancel()
    }
}