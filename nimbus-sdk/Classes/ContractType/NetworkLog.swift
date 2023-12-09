//
//  NetworkLog.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

public struct NetworkLog {
    var statusCode: String
    var httpVerb: String
    var endpoint: String
    var queryParams: [String: Any]
    var baseURL: String
    var headers: [String: String]
    var jsonRepsonse: Data
    
    public init(statusCode: String, httpVerb: String, endpoint: String, queryParams: [String: Any], baseURL: String, headers: [String: String], jsonRepsonse: Data) {
        self.statusCode = statusCode
        self.httpVerb = httpVerb
        self.endpoint = endpoint
        self.queryParams = queryParams
        self.baseURL = baseURL
        self.headers = headers
        self.jsonRepsonse = jsonRepsonse
    }
}
