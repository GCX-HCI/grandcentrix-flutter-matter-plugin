// Autogenerated from Pigeon (v12.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package net.grandcentrix.flutter_matter

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is FlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class FlutterError (
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

/** Generated class from Pigeon that represents data sent in messages. */
data class MatterDevice (
  val id: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): MatterDevice {
      val id = list[0].let { if (it is Int) it.toLong() else it as Long }
      return MatterDevice(id)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      id,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class CommissionRequest (
  val id: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): CommissionRequest {
      val id = list[0].let { if (it is Int) it.toLong() else it as Long }
      return CommissionRequest(id)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      id,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class OpenPairingWindowResult (
  val manualPairingCode: String? = null,
  val qrCode: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): OpenPairingWindowResult {
      val manualPairingCode = list[0] as String?
      val qrCode = list[1] as String?
      return OpenPairingWindowResult(manualPairingCode, qrCode)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      manualPairingCode,
      qrCode,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AndroidError (
  /** An error code. */
  val code: String,
  /** A human-readable error message, possibly null. */
  val message: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): AndroidError {
      val code = list[0] as String
      val message = list[1] as String?
      return AndroidError(code, message)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      code,
      message,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class DescriptorClusterDeviceTypeStruct (
  val deviceType: Long,
  val revision: Long

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): DescriptorClusterDeviceTypeStruct {
      val deviceType = list[0].let { if (it is Int) it.toLong() else it as Long }
      val revision = list[1].let { if (it is Int) it.toLong() else it as Long }
      return DescriptorClusterDeviceTypeStruct(deviceType, revision)
    }
  }
  fun toList(): List<Any?> {
    return listOf<Any?>(
      deviceType,
      revision,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object FlutterMatterHostApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          CommissionRequest.fromList(it)
        }
      }
      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          MatterDevice.fromList(it)
        }
      }
      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          OpenPairingWindowResult.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is CommissionRequest -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      is MatterDevice -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }
      is OpenPairingWindowResult -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface FlutterMatterHostApi {
  fun getPlatformVersion(callback: (Result<String>) -> Unit)
  fun commission(request: CommissionRequest, callback: (Result<MatterDevice>) -> Unit)
  fun unpair(deviceId: Long, callback: (Result<Unit>) -> Unit)
  fun openPairingWindowWithPin(deviceId: Long, duration: Long, discriminator: Long, setupPin: Long, callback: (Result<OpenPairingWindowResult>) -> Unit)

  companion object {
    /** The codec used by FlutterMatterHostApi. */
    val codec: MessageCodec<Any?> by lazy {
      FlutterMatterHostApiCodec
    }
    /** Sets up an instance of `FlutterMatterHostApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: FlutterMatterHostApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostApi.getPlatformVersion", codec)
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getPlatformVersion() { result: Result<String> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostApi.commission", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val requestArg = args[0] as CommissionRequest
            api.commission(requestArg) { result: Result<MatterDevice> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostApi.unpair", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            api.unpair(deviceIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostApi.openPairingWindowWithPin", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val durationArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            val discriminatorArg = args[2].let { if (it is Int) it.toLong() else it as Long }
            val setupPinArg = args[3].let { if (it is Int) it.toLong() else it as Long }
            api.openPairingWindowWithPin(deviceIdArg, durationArg, discriminatorArg, setupPinArg) { result: Result<OpenPairingWindowResult> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface FlutterMatterHostOnOffClusterApi {
  fun off(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit)
  fun on(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit)
  fun toggle(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit)
  fun readOnOff(deviceId: Long, endpointId: Long, callback: (Result<Boolean>) -> Unit)
  fun subscribeToOnOff(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit)
  fun unsubscribeToOnOff(deviceId: Long, endpointId: Long, callback: (Result<Unit>) -> Unit)

  companion object {
    /** The codec used by FlutterMatterHostOnOffClusterApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `FlutterMatterHostOnOffClusterApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: FlutterMatterHostOnOffClusterApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostOnOffClusterApi.off", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.off(deviceIdArg, endpointIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostOnOffClusterApi.on", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.on(deviceIdArg, endpointIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostOnOffClusterApi.toggle", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.toggle(deviceIdArg, endpointIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostOnOffClusterApi.readOnOff", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readOnOff(deviceIdArg, endpointIdArg) { result: Result<Boolean> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostOnOffClusterApi.subscribeToOnOff", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.subscribeToOnOff(deviceIdArg, endpointIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostOnOffClusterApi.unsubscribeToOnOff", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.unsubscribeToOnOff(deviceIdArg, endpointIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object FlutterMatterFlutterOnOffClusterApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AndroidError.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is AndroidError -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class FlutterMatterFlutterOnOffClusterApi(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by FlutterMatterFlutterOnOffClusterApi. */
    val codec: MessageCodec<Any?> by lazy {
      FlutterMatterFlutterOnOffClusterApiCodec
    }
  }
  fun onOff(deviceIdArg: Long, endpointIdArg: Long, onOffArg: Boolean?, errorArg: AndroidError?, callback: (Result<Unit>) -> Unit) {
    val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterFlutterOnOffClusterApi.onOff", codec)
    channel.send(listOf(deviceIdArg, endpointIdArg, onOffArg, errorArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(Result.failure(FlutterError(it[0] as String, it[1] as String, it[2] as String?)));
        } else {
          callback(Result.success(Unit));
        }
      } else {
        callback(Result.failure(FlutterError("channel-error",  "Unable to establish connection on channel.", "")));
      } 
    }
  }
}
@Suppress("UNCHECKED_CAST")
private object FlutterMatterHostDescriptorClusterApiCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          DescriptorClusterDeviceTypeStruct.fromList(it)
        }
      }
      else -> super.readValueOfType(type, buffer)
    }
  }
  override fun writeValue(stream: ByteArrayOutputStream, value: Any?)   {
    when (value) {
      is DescriptorClusterDeviceTypeStruct -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }
      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface FlutterMatterHostDescriptorClusterApi {
  fun readDeviceTypeList(deviceId: Long, endpointId: Long, callback: (Result<List<DescriptorClusterDeviceTypeStruct>>) -> Unit)
  fun readServerList(deviceId: Long, endpointId: Long, callback: (Result<List<Long>>) -> Unit)
  fun readClientList(deviceId: Long, endpointId: Long, callback: (Result<List<Long>>) -> Unit)
  fun readPartsList(deviceId: Long, endpointId: Long, callback: (Result<List<Long>>) -> Unit)

  companion object {
    /** The codec used by FlutterMatterHostDescriptorClusterApi. */
    val codec: MessageCodec<Any?> by lazy {
      FlutterMatterHostDescriptorClusterApiCodec
    }
    /** Sets up an instance of `FlutterMatterHostDescriptorClusterApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: FlutterMatterHostDescriptorClusterApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostDescriptorClusterApi.readDeviceTypeList", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readDeviceTypeList(deviceIdArg, endpointIdArg) { result: Result<List<DescriptorClusterDeviceTypeStruct>> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostDescriptorClusterApi.readServerList", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readServerList(deviceIdArg, endpointIdArg) { result: Result<List<Long>> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostDescriptorClusterApi.readClientList", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readClientList(deviceIdArg, endpointIdArg) { result: Result<List<Long>> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostDescriptorClusterApi.readPartsList", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readPartsList(deviceIdArg, endpointIdArg) { result: Result<List<Long>> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface FlutterMatterHostTemperatureClusterApi {
  fun readMeasuredValue(deviceId: Long, endpointId: Long, callback: (Result<Long?>) -> Unit)
  fun readMinMeasuredValue(deviceId: Long, endpointId: Long, callback: (Result<Long?>) -> Unit)
  fun readMaxMeasuredValue(deviceId: Long, endpointId: Long, callback: (Result<Long?>) -> Unit)
  fun readTolerance(deviceId: Long, endpointId: Long, callback: (Result<Long?>) -> Unit)

  companion object {
    /** The codec used by FlutterMatterHostTemperatureClusterApi. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
    /** Sets up an instance of `FlutterMatterHostTemperatureClusterApi` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: FlutterMatterHostTemperatureClusterApi?) {
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostTemperatureClusterApi.readMeasuredValue", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readMeasuredValue(deviceIdArg, endpointIdArg) { result: Result<Long?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostTemperatureClusterApi.readMinMeasuredValue", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readMinMeasuredValue(deviceIdArg, endpointIdArg) { result: Result<Long?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostTemperatureClusterApi.readMaxMeasuredValue", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readMaxMeasuredValue(deviceIdArg, endpointIdArg) { result: Result<Long?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostTemperatureClusterApi.readTolerance", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            api.readTolerance(deviceIdArg, endpointIdArg) { result: Result<Long?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}
