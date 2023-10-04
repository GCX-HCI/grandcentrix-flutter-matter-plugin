package net.grandcentrix.flutter_matter.interfaces

import net.grandcentrix.flutter_matter.Attribute

interface IAttributeHandler {
    suspend fun handle(
        deviceId: Long,
        endpointId: Long,
        attribute: Attribute
    ): Any
}