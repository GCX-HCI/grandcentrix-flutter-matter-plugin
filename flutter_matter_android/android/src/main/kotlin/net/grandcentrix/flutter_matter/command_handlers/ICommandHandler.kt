package net.grandcentrix.flutter_matter.command_handlers

import net.grandcentrix.flutter_matter.Command

interface ICommandHandler {
    suspend fun handle(
        deviceId: Long,
        endpointId: Long,
        command: Command
    )
}