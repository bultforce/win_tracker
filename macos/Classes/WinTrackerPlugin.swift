import Cocoa
import Foundation
import FlutterMacOS


public class WinTrackerPlugin: NSObject, FlutterPlugin{
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "win_tracker", binaryMessenger: registrar.messenger)
        
        let instance = WinTrackerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getOpenWindowTitle":
            getOpenWindowTitle(call, result: result)
            break
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    
    public func getOpenWindowTitle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let app = NSWorkspace.shared.frontmostApplication
       {
        let appName = app.localizedName!
        if appName == "Safari"
               {
                let openUrl = self.getBrowserURL("Safari") ?? "Safari"
                result(["isApp":"false","application":appName, "openUrl":openUrl])
               }
               else if appName == "Google Chrome"
               {
                 let openUrl = self.getBrowserURL("Google Chrome") ?? "Google Chrome"
                  result(["isApp":"false","application":appName, "openUrl":openUrl])
               }
               else{
               result(["isApp":"true","application":appName, "openUrl":"" ])
               }
       }

    }

        func getBrowserURL(_ appName: String) -> String? {
         guard let scriptText = getScriptText(appName) else { return nil }
          var error: NSDictionary?
          guard let script = NSAppleScript(source: scriptText) else { return nil }
          guard let outputString = script.executeAndReturnError(&error).stringValue else {
              if let error = error {
            print("Get Browser URL request failed with error: \(error.description)")
             }
              return nil
          }
          // clean url output - remove protocol & unnecessary "www."
          if let url = URL(string: outputString),
              var host = url.host {
             // print("Host: \(host)")
             //  print("Path: \(url.path)")

              if host.hasPrefix("www.") {
                  host = String(host.dropFirst(4))
              }
              let resultURL = "\(url.absoluteString)"
              return resultURL
          }
          return nil
        }

    func getScriptText(_ appName: String) -> String? {
        switch appName {
        case "Google Chrome":
            return "tell app \"Google Chrome\" to get the url of the active tab of window 1"
        case "Safari":
            return "tell application \"Safari\" to return URL of front document"
        default:
            return nil
        }
    }

}
