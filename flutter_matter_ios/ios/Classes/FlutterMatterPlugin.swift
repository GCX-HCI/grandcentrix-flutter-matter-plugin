import Flutter
import UIKit

public class FlutterMatterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let flutterMatterHostApi = FlutterMatterHostApiImpl()
      FlutterMatterHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: flutterMatterHostApi)
  }
}
