import FlutterMacOS

class KeyBoardEventProvider: NSObject, FlutterStreamHandler {
  var eventSink: FlutterEventSink?

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    print("listening to ColorPanelProvider events")
    eventSink = events
    return nil
  }

  func openPanel() {
    startStream()
  }



  @objc public func startStream() {
    print("starting ColorPanelProvider stream")
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
    return nil
  }
}
}
