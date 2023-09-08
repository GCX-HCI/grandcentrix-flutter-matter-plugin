import Flutter
import UIKit
import Quick
import Nimble

@testable import flutter_matter_ios

class TableOfContentsSpec: QuickSpec {
    override class func spec() {
        describe("FlutterMatterHostApiImpl") {
            
            context("getPlatformVersion") {
                
                it("should return correct version string") {
                    let sut = FlutterMatterHostApiImpl()
                    var returnedVersionString = ""
                    
                    waitUntil { done in
                       
                        sut.getPlatformVersion { result in
                            do {
                                returnedVersionString = try result.get()
                            }
                            catch{
                                fail()
                            }
                        }
                        
                        expect(returnedVersionString).to(equal("iOS " + UIDevice.current.systemVersion))

                        done()
                    }
                }
            }
        }
    }
}
