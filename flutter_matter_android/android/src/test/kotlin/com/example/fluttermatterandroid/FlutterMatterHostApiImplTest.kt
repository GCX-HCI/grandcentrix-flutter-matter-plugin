package com.example.fluttermatterandroid

import net.grandcentrix.fluttermatter.FlutterMatterHostApiImpl
import kotlin.test.Test
import kotlin.test.assertEquals

internal class FlutterMatterHostApiImplTest {
    @Test
    fun onMethodCall_getPlatformVersion_returnsExpectedValue() {
        val sut = FlutterMatterHostApiImpl()

        var resultFromCallback: Result<String> = Result.failure(Throwable())
        sut.getPlatformVersion { result: Result<String> -> resultFromCallback = result }

        assertEquals(resultFromCallback.getOrThrow(), "Android " + android.os.Build.VERSION.RELEASE)
    }
}
