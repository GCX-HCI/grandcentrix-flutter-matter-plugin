//
//  FlutterMatterHostApiImpl.swift
//  flutter_matter_ios
//
//  Created by Philipp Manstein on 08.09.23.
//

import Foundation

class FlutterMatterHostApiImpl : FlutterMatterHostApi
{
    func getPlatformVersion(completion: @escaping (Result<String, Error>) -> Void) {
        completion(Result.success("iOS " + UIDevice.current.systemVersion))
    }
}
