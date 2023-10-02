//
//  CommandHandler.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 19.09.23.
//

import Foundation

protocol CommandHandler {
    func handle(_ command: Command, deviceId: Int64, endpointId: Int64) async throws
}
