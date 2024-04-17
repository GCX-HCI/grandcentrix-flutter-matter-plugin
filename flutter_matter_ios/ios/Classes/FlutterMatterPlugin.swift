import Flutter
import UIKit

public class FlutterMatterPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()

        let flutterMatterHostApi = FlutterMatterHostApiImpl()
        FlutterMatterHostApiSetup.setUp(binaryMessenger: messenger, api: flutterMatterHostApi)

        let onOffClusterFlutterApi = FlutterMatterFlutterOnOffClusterApi(binaryMessenger: messenger)
        let onOffCluster = OnOffCluster(flutterApi: onOffClusterFlutterApi)
        FlutterMatterHostOnOffClusterApiSetup.setUp(binaryMessenger: messenger, api: onOffCluster)

        let descriptorCluster = DescriptorCluster()
        FlutterMatterHostDescriptorClusterApiSetup.setUp(binaryMessenger: messenger, api: descriptorCluster)

        let temperatureCluster = TemperatureCluster()
        FlutterMatterHostTemperatureClusterApiSetup.setUp(binaryMessenger: messenger, api: temperatureCluster)
    }
}
