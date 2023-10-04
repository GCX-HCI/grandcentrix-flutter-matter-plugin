// Autogenerated from Pigeon (v11.0.1), do not edit directly.
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

/** Commands for the different clusters, check the Matter Device Library Specification document */
enum class Command(val raw: Int) {
  /** Command for the on/off cluster */
  OFF(0),
  /** Command for the on/off cluster */
  ON(1),
  /** Command for the on/off cluster */
  TOGGLE(2);

  companion object {
    fun ofRaw(raw: Int): Command? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Attributes for the different clusters, check the Matter Device Library Specification document */
enum class Attribute(val raw: Int) {
  /** Attribute for the on/off cluster */
  ONOFF(0);

  companion object {
    fun ofRaw(raw: Int): Attribute? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Matter clusters, check the Matter Device Library Specification document */
enum class Cluster(val raw: Int) {
  /** Cluster ID 0x0006 for turning devices on and off. */
  ONOFF(0);

  companion object {
    fun ofRaw(raw: Int): Cluster? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

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
  fun command(deviceId: Long, endpointId: Long, cluster: Cluster, command: Command, callback: (Result<Unit>) -> Unit)
  fun attribute(deviceId: Long, endpointId: Long, cluster: Cluster, attribute: Attribute, callback: (Result<Any>) -> Unit)

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
      run {
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostApi.command", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            val clusterArg = Cluster.ofRaw(args[2] as Int)!!
            val commandArg = Command.ofRaw(args[3] as Int)!!
            api.command(deviceIdArg, endpointIdArg, clusterArg, commandArg) { result: Result<Unit> ->
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
        val channel = BasicMessageChannel<Any?>(binaryMessenger, "dev.flutter.pigeon.flutter_matter_android.FlutterMatterHostApi.attribute", codec)
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val deviceIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val endpointIdArg = args[1].let { if (it is Int) it.toLong() else it as Long }
            val clusterArg = Cluster.ofRaw(args[2] as Int)!!
            val attributeArg = Attribute.ofRaw(args[3] as Int)!!
            api.attribute(deviceIdArg, endpointIdArg, clusterArg, attributeArg) { result: Result<Any> ->
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
