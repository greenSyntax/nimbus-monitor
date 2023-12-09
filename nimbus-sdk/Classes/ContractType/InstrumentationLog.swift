//
//  InstrumentationLog.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

public struct InstrumentationLog {
    var eventName: String
    var attributes: [String: Any]
    
    public init(_ eventName: String, _ attributes: [String: Any]) {
        self.eventName = eventName
        self.attributes = attributes
    }
}
