//
//  AttributeHandler.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 04.10.23.
//

import Foundation

protocol AttributeHandler {
    func handle(_ attribute: Attribute, deviceId: Int64, endpointId: Int64) async throws -> Any
}
