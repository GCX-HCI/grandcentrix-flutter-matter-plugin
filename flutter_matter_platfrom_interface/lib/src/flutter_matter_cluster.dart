/// Matter clusters, check the Matter Device Library Specification document
enum FlutterMatterCluster {
  // /// Cluster ID 0x0003 supports an endpoint identification state (e.g., flashing a light), that indicates to an observer (e.g., an installer) which of several nodes and/or endpoints it is. It also supports a multi­ cast request that any endpoint that is identifying itself to respond to the initiator.
  // identify,

  // /// Cluster ID 0x0004 cluster manages, per endpoint, the content of the node-wide Group Table that is part of the underlying interaction layer.
  // groups,

  // /// Cluster ID 0x0005 provides attributes and commands for setting up and recalling scenes. Each scene corresponds to a set of stored values of specified attributes for one or more clusters on the same end point as the Scenes cluster.
  // scenes,

  /// Cluster ID 0x0006 for turning devices on and off.
  onOff,

  // /// Cluster ID 0x0008 provides an interface for controlling a characteristic of a device that can be set to a level, for example the brightness of a light, the degree of closure of a door, or the power output of a heater.
  // level,
  // // levelControlForLight,
  // // pwm,

  // /// Cluster ID 0x0045 provides an interface to a boolean state called StateValue.
  // booleanState,

  // /// Cluster ID 0x0050 provides an interface for controlling a characteristic of a device that can be set to one of several predefined values. For example, the light pattern of a disco ball, the mode of a massage chair, or the wash cycle of a laundry machine.
  // modeSelect,

  // /// Cluster ID 0x0508 provides an interface for managing low power mode on a device.
  // lowPower,

  // /// Cluster ID 0x0503
  // wakeOnLan,

  // /// Cluster ID 0x003b
  // switchCluster,

  // /// Cluster ID 0x0406
  // occupancySensing,

  // /// Cluster ID 0x0300
  // colorControl,
}
