import Cocoa
import FlutterMacOS


public class WinTrackerPlugin: NSObject, FlutterPlugin, FlutterStreamHandler  {
    var keyBoardEventSink: FlutterEventSink?
    var mouseEventSink: FlutterEventSink?
    var keyBoardEventMonitor: EventMonitor?
    var localEventMonitor: LocalEventMonitor?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "win_tracker", binaryMessenger: registrar.messenger)
        let keyBoardEventChannel = FlutterEventChannel(name: "win_tracker_keyboard", binaryMessenger: registrar.messenger)
        let mouseEventChannel = FlutterEventChannel(name: "win_tracker_mouse",binaryMessenger: registrar.messenger)
        
        keyBoardEventChannel.setStreamHandler(WinTrackerPlugin())
        mouseEventChannel.setStreamHandler(WinTrackerPlugin())
        
        let instance = WinTrackerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    
    
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("listening to events")
       
       
        if let argument = arguments as? String {
                   if (argument == "keyBoard_event") {
                       self.keyBoardEventSink = events
                       let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String :  true]
                       let accessEnabled = AXIsProcessTrustedWithOptions(options)
                       if !accessEnabled {
                           print("Access Not Enabled") }
                       else{
                           print("permission passes")
                           keyBoardEventMonitor = EventMonitor(mask: [.keyUp,.keyDown,.mouseMoved,.leftMouseUp,.rightMouseUp,.rightMouseDown,
                                                                      .rightMouseDragged,.leftMouseDown,.leftMouseDragged,.mouseMoved,.flagsChanged,.cursorUpdate,.scrollWheel, .otherMouseDown,
                                                                      .otherMouseDragged,.otherMouseUp, .mouseEntered,.mouseExited]) {[weak self] event in
                                                                          if let tempEvent = event
                                                                          {
                                                                              if tempEvent.type == NSEvent.EventType.keyUp || tempEvent.type == NSEvent.EventType.keyDown
                                                                              {
                                                                                  
                                                                                  events("keyboardEvent");
                                                                              }
                                                                    
                                                                              else
                                                                              {

                                                                              }
                                                                          }
                                                                      }
                           keyBoardEventMonitor?.start()
                       }
                   } else if (argument == "mouse_event") {
                       self.mouseEventSink = events
                       let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as String :  true]
                       let accessEnabled = AXIsProcessTrustedWithOptions(options)
                       if !accessEnabled {
                           print("Access Not Enabled") }
                       else{
                           print("permission passes")
                           keyBoardEventMonitor = EventMonitor(mask: [.keyUp,.keyDown,.mouseMoved,.leftMouseUp,.rightMouseUp,.rightMouseDown,
                                                                      .rightMouseDragged,.leftMouseDown,.leftMouseDragged,.mouseMoved,.flagsChanged,.cursorUpdate,.scrollWheel, .otherMouseDown,
                                                                      .otherMouseDragged,.otherMouseUp, .mouseEntered,.mouseExited]) {[weak self] event in
                                                                          if let tempEvent = event
                                                                          {
                                                                            if tempEvent.type == NSEvent.EventType.leftMouseDown || tempEvent.type == NSEvent.EventType.leftMouseUp || tempEvent.type == NSEvent.EventType.rightMouseDown || tempEvent.type == NSEvent.EventType.rightMouseUp || tempEvent.type == NSEvent.EventType.mouseMoved || tempEvent.type == NSEvent.EventType.leftMouseDragged || tempEvent.type == NSEvent.EventType.rightMouseDragged || tempEvent.type == NSEvent.EventType.mouseEntered || tempEvent.type == NSEvent.EventType.mouseExited || tempEvent.type == NSEvent.EventType.rightMouseDragged || tempEvent.type == NSEvent.EventType.flagsChanged || tempEvent.type == NSEvent.EventType.cursorUpdate || tempEvent.type == NSEvent.EventType.scrollWheel || tempEvent.type == NSEvent.EventType.otherMouseDown || tempEvent.type == NSEvent.EventType.otherMouseUp || tempEvent.type == NSEvent.EventType.scrollWheel || tempEvent.type == NSEvent.EventType.otherMouseDragged
                                                                              {
                                                                                  
                                                                                  events("mouseEvent");
                                                                              }
                                                                              else
                                                                              {

                                                                              }
                                                                          }
                                                                      }
                           keyBoardEventMonitor?.start()
                       }
                   } else {
                       // Unknown stream listener registered
                   }
               }
        return nil
    }
    
    
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        WinTrackerPlugin().keyBoardEventSink = nil
        WinTrackerPlugin().mouseEventSink = nil
        return nil
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
        case "isAccessAllowed":
            isAccessAllowed(call, result: result)
            break
        case "requestPermission":
            requestAccess(call, result: result)
            break
        case "screenCapture":
            screenCapture(call, result: result)
            break
        case "getOpenWindowTitle":
            getOpenWindowTitle(call, result: result)
            break
        case "getOpenUrl":
            getOpenUrl(call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func isAccessAllowed(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if #available(macOS 10.16, *) {
            result(CGPreflightScreenCaptureAccess())
            return
        };
        result(true)
    }
    
    public func getOpenWindowTitle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("getOpenWindowTitle---Native")
    }
    
    public func getOpenUrl(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("getOpenUrl---Native")
    }
    
    private func getDirectory(ofType directory: FileManager.SearchPathDirectory) -> String? {
        let paths = NSSearchPathForDirectoriesInDomains(
            directory,
            FileManager.SearchPathDomainMask.userDomainMask,
            true)
        return paths.first
    }
    
    public func screenCapture(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args:[String: Any] = call.arguments as! [String: Any]
        let fileName: String = args["fileName"] as! String
        let filePath: String = args["filePath"] as! String
        let imgPath: String = filePath+"/"+fileName
        print("\(imgPath)")
        let destt = URL(fileURLWithPath: imgPath)
        let img = CGDisplayCreateImage(CGMainDisplayID())
        let dest = CGImageDestinationCreateWithURL(destt as CFURL, kUTTypePNG, 1, nil)
        CGImageDestinationAddImage(dest!, img!, nil)
        CGImageDestinationFinalize(dest!)
        
        print("\(imgPath)")
        result(true)
    }
    
    public func requestAccess(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args:[String: Any] = call.arguments as! [String: Any]
        let onlyOpenPrefPane: Bool = args["onlyOpenPrefPane"] as! Bool
        
        if (!onlyOpenPrefPane) {
            if #available(macOS 10.16, *) {
                CGRequestScreenCaptureAccess()
            } else {
                // Fallback on earlier versions
            }
        } else {
            let prefpaneUrl = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenCapture")!
            NSWorkspace.shared.open(prefpaneUrl)
        }
        result(true)
    }
}
public class EventMonitor {
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> Void
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void) {
        self.mask = mask
        self.handler = handler
    }
    deinit {
        stop()
    }
    
    public func start() {
        print("kjbkjbkbj")
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
public class LocalEventMonitor {
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    private let handler: (NSEvent?) -> NSEvent
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> NSEvent) {
        self.mask = mask
        self.handler = handler
    }
    deinit {
        stop()
    }
    
    public func start() {
        monitor = NSEvent.addLocalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
    
}
