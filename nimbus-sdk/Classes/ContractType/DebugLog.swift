//
//  DebugLog.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

public struct Log {
    var tag: String
    var title: String
    var body: String
    
    public init(tag: String, title: String, body: String) {
        self.tag = tag
        self.title = title
        self.body = body
    }
}
