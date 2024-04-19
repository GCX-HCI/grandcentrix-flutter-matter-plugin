/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package net.grandcentrix.fluttermatter

import android.content.Intent

// -------------------------------------------------------------------------------------------------
// System helper functions

fun isMultiAdminCommissioning(intent: Intent): Boolean {
    return intent.action == "com.google.android.gms.home.matter.ACTION_COMMISSION_DEVICE"
}

/**
 * Strip the link-local portion of an IP Address. Was needed to handle
 * https://github.com/google-home/sample-app-for-matter-android/issues/15. For example:
 * ```
 *    "fe80::84b1:c2f6:b1b7:67d4%wlan0"
 * ```
 *
 * becomes
 *
 * ```
 *    ""fe80::84b1:c2f6:b1b7:67d4"
 * ```
 *
 * The "%wlan0" at the end of the link-local ip address is stripped.
 */
fun stripLinkLocalInIpAddress(ipAddress: String): String {
    return ipAddress.replace("%.*".toRegex(), "")
}

/**
 * Indicates the status of a node's commissioning window. Useful in the context of "multi-admin"
 * when a temporary commissioning window must be open for a target commissioner. That's because
 * sometimes multi-admin may fail with the target commissioner (especially in a testing environment)
 * and the temporary commissioning window can then stay open for a substantial amount of time (e.g.
 * 3 minutes) preventing a new "multi-admin" to fail until that temporary commissioning window is
 * closed. Checking on the status of the commissioning window beforehand makes it possible to close
 * the currently open temporary commissioning window before trying to open a new one. [status] is
 * the enum value returned by reading the WindowStatusAttribute of the "Administrator Commissioning
 * Cluster". (See spec section "11.18.6.1. CommissioningWindowStatus enum").
 */
enum class CommissioningWindowStatus(val status: Int) {
    /** Commissioning window not open */
    WindowNotOpen(0),

    /** An Enhanced Commissioning Method window is open */
    EnhancedWindowOpen(1),

    /** A Basic Commissioning Method window is open */
    BasicWindowOpen(2),
}
