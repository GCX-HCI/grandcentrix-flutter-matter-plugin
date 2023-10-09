import Flutter
import UIKit

public class FlutterMatterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      
      let messenger = registrar.messenger()
      let flutterMatterHostApi = FlutterMatterHostApiImpl()
      let onOffCluster = OnOffCluster();
      let descriptorCluster = DescriptorCluster();
      
      FlutterMatterHostApiSetup.setUp(binaryMessenger: messenger, api: flutterMatterHostApi)
      FlutterMatterHostOnOffClusterApiSetup.setUp(binaryMessenger: messenger, api: onOffCluster)
      FlutterMatterHostDescriptorClusterApiSetup.setUp(binaryMessenger: messenger, api: descriptorCluster)
  }
}
