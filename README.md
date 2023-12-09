# Nimbus 500 🐝
Pluggable iOS SDK made to build to track and monitor *API Traffic* and *Debug Logs*. And, Yes, Nimbuss 500 a Harry Potter Reference. It will pop when you shake your iPhone.

## Features

- [x] API Traffic Monitor
- [x] Analytics Instrumententation Tracking
- [x] Debug Console Logs


## Installation

nimbus-sdk is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'NimbusMonitor', :git => 'git@github.com:greenSyntax/nimbus-monitor.git', :tag => '1.0.9'
```


## Integration

You just need to write a single line of code - 

```swift
    NimbussService().monitor()
```

## Customization

You can write something similar,
```swift
import Foundation
import NimbusMonitor
import Alamofire

final class DebugMonitor {
    
    private let nimbus = NimbussService()
    
    static let shared = DebugMonitor()
    
    private init() {
        nimbus.monitor()
        startNetworkTrafficMonitoring()
    }
    
    /// Log Analytics Data or Instrumentaion
    /// - Parameters:
    ///   - eventName: EventName
    ///   - attributes: Attributes Payload
    func logEvent(_ eventName: String, _ attributes: [String: Any]) {
        #if DEBUG
        nimbus.write(.instrumentation(InstrumentationLog(eventName, attributes)))
        #endif
    }
    
    /// Log HTTP API Response
    /// - Parameters:
    ///   - statusCode: HTTP Response
    ///   - httpVerb: HTTP Vern
    ///   - endpoint: API Endpoint
    ///   - queryParams: Request Query Params
    ///   - baseURL: Base URL
    ///   - headers: HTTP Headers
    ///   - responseData: HTTP Response Data in JSON
    func logNetworkTraffic(statusCode: String, httpVerb: String, endpoint: String, queryParams: [String: Any], baseURL: String, headers: [String: String], responseData: Data ) {
        #if DEBUG
        nimbus.write(.network(NetworkLog(statusCode: statusCode, httpVerb: httpVerb, endpoint: endpoint, queryParams: queryParams, baseURL: baseURL, headers: headers, jsonRepsonse: responseData)))
        #endif
    }
    
    /// Just Debug Logs which you want to watch
    /// - Parameters:
    ///   - tag: TAG NAME like DEBUG, INFO, ERROR and WARNING
    ///   - title: Title Text
    ///   - content: Content Text
    func debug(_ tag: String = "debug", _ title: String, _ content: String) {
        #if DEBUG
        nimbus.write(.debug(Log(tag: tag, title: title, body: content)))
        #endif
    }
    
}

extension DebugMonitor {
    
    /// Monitor HTTP Traffic from Alamofire
    func startNetworkTrafficMonitoring() {
        NotificationCenter.default.addObserver(self, selector: #selector(processAlamofireResponseData), name: Alamofire.Request.didCompleteTaskNotification, object: nil)
    }
    
    @objc private func processAlamofireResponseData(_ notificatio: Notification) {
        guard let request = notificatio.request as? DataRequest else { return }
        
        self.logNetworkTraffic(statusCode: "\(request.response?.statusCode ?? 0)", httpVerb: request.request?.httpMethod ?? "NA", endpoint: request.request?.url?.lastPathComponent ?? "NA", queryParams: [:], baseURL: request.request?.url?.absoluteString ?? "NA", headers: request.request?.allHTTPHeaderFields ?? [:], responseData: request.data ?? Data())
    }
    
}

```

## Author

Abhishek Ravi - ab.bhishek.ravi@gmail.com

## License

NimbusMonitor is available under the MIT license. See the LICENSE file for more info.
