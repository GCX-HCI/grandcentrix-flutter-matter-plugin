package net.grandcentrix.fluttermatter

import android.content.ComponentName
import android.content.Intent
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.longPreferencesKey
import com.google.android.gms.home.matter.Matter
import com.google.android.gms.home.matter.commissioning.CommissioningRequest
import com.google.android.gms.home.matter.commissioning.CommissioningResult
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import net.grandcentrix.fluttermatter.chip.ChipClient
import net.grandcentrix.fluttermatter.commissioning.AppCommissioningService
import timber.log.Timber
import java.io.Closeable

class FlutterMatterHostApiImpl : FlutterMatterHostApi, Closeable {
    var activity: android.app.Activity? = null
    private var callback: ((Result<MatterDevice>) -> Unit)? = null

    private val scope =
        CoroutineScope(Dispatchers.IO + Job())

    // FlutterMatterHostApi
    override fun getPlatformVersion(callback: (Result<String>) -> Unit) {
        callback(Result.success("Android ${android.os.Build.VERSION.RELEASE}"))
    }

    override fun initParams(params: InitParams) {
        runBlocking {
            activity?.dataStore?.edit { preferences ->
                preferences[intPreferencesKey("vendor_id")] = params.vendorId.toInt()
                preferences[longPreferencesKey("fabric_id")] = params.fabricId
            }
        }
    }

    override fun commission(
        request: CommissionRequest,
        callback: (Result<MatterDevice>) -> Unit,
    ) {
        Timber.d("CommissionDevice: starting")
        val commissioningRequest =
            CommissioningRequest.builder()
                .setCommissioningService(ComponentName(activity!!, AppCommissioningService::class.java))
                .build()

        AppCommissioningService.deviceId = request.id

        // The call to commissionDevice() creates the IntentSender that will eventually be launched
        // in the fragment to trigger the commissioning activity in GPS.
        Matter.getCommissioningClient(activity!!)
            .commissionDevice(commissioningRequest)
            .addOnSuccessListener { result ->
                Timber.d("ShareDevice: Success getting the IntentSender: result [$result]")
                this.callback = callback
                activity!!.startIntentSenderForResult(
                    result,
                    1001,
                    Intent(),
                    Integer.valueOf(0),
                    Integer.valueOf(0),
                    Integer.valueOf(0),
                    null,
                )
            }
            .addOnFailureListener { error ->
                Timber.e(error, "Failed to set up device")
                callback(Result.failure(FlutterError("-1", "Failed to set up device")))
            }
    }

    override fun unpair(
        deviceId: Long,
        callback: (Result<Unit>) -> Unit,
    ) {
        scope.launch {
            try {
                val chipClient = ChipClient(activity!!)
                chipClient.awaitUnpairDevice(deviceId)
                callback(Result.success(Unit))
            } catch (e: Exception) {
                Timber.e(e, "Failed to unpair device")
                callback(Result.failure(FlutterError("-1", "Failed to unpair device")))
            }
        }
    }

    override fun openPairingWindowWithPin(
        deviceId: Long,
        duration: Long,
        discriminator: Long,
        setupPin: Long,
        callback: (Result<OpenPairingWindowResult>) -> Unit,
    ) {
        scope.launch {
            try {
                val chipClient = ChipClient(activity!!)
                val devicePtr = chipClient.getConnectedDevicePointer(deviceId)
                val (_: Long, manualPairingCode: String?, qrCode: String?) =
                    chipClient.awaitOpenPairingWindowWithPIN(
                        devicePtr,
                        duration.toInt(),
                        10000L,
                        discriminator.toInt(),
                        setupPin,
                    )
                callback(Result.success(OpenPairingWindowResult(manualPairingCode, qrCode)))
            } catch (e: Exception) {
                Timber.e(e, "Failed to openPairingWindowWithPin for device")
                callback(Result.failure(FlutterError("-1", "Failed to openPairingWindowWithPin for device")))
            }
        }
    }

    fun onActivityResult(
        requestCode: Int,
        resultCode: Int,
        data: Intent?,
    ): Boolean {
        when (resultCode) {
            android.app.Activity.RESULT_OK -> {
                // Proceed to get this device's details
                if (data != null) {
                    // Get the Device Data and send it back
                    val result: CommissioningResult =
                        CommissioningResult.fromIntentSenderResult(
                            resultCode,
                            data,
                        )
                    Timber.i("Commissioned Device data: $result")

                    val commissionedDevice: HashMap<String, Any> = HashMap()
                    if (result.token == null) {
                        Timber.e("Failed to set up device: No token in response")
                        callback!!(
                            Result.failure(
                                FlutterError(
                                    "-1",
                                    "Failed to set up device: No token in response",
                                ),
                            ),
                        )
                        return false
                    } else {
                        commissionedDevice["deviceId"] = result.token?.toLong()!!
                    }
                    commissionedDevice["deviceName"] = result.deviceName
                    commissionedDevice["vendorId"] = result.commissionedDeviceDescriptor.vendorId
                    commissionedDevice["describeContents"] =
                        result.commissionedDeviceDescriptor.describeContents()

                    callback!!(Result.success(MatterDevice(result.token?.toLong()!!)))
                }
            }

            else -> {
                Timber.e("Failed to set up device: User Cancelled")
                callback!!(Result.failure(FlutterError("-3", "Failed to set up device: User Cancelled")))
            }
        }

        return resultCode == android.app.Activity.RESULT_OK
    }

    override fun close() {
        scope.cancel()
    }
}
