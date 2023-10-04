package net.grandcentrix.flutter_matter.interfaces

import net.grandcentrix.flutter_matter.Command

interface ICommandHandler {
    suspend fun handle(
        deviceId: Long,
        endpointId: Long,
        command: Command
    )
}