//
//  FlutterMatterHostApiImplTests.swift
//  RunnerTests
//
//  Created by Philipp Manstein on 06.10.23.
//

import Flutter
import UIKit
import XCTest

@testable import flutter_matter_ios

class FlutterMatterHostApiImplTests: XCTestCase {
    func testGetPlatformVersion() {
        let sut = FlutterMatterHostApiImpl()

        let resultExpectation = expectation(description: "result block must be called.")

        sut.getPlatformVersion { result in
            switch result {
            case let .success(res):
                XCTAssertEqual(res, "iOS " + UIDevice.current.systemVersion)
                resultExpectation.fulfill()
            default:
                break
            }
        }

        waitForExpectations(timeout: 1)
    }
}
