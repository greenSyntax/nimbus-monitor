//
//  NetworkCellData.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

struct NetworkCellData {
    var uid: String
    var baseURL: String
    var endpoint: String
    var headers: String
    var httpVerb: String
    var jsonResponse: String
    var queryParams: String
    var statusCode: String
    var timestamp: String
    
    var tagColor: UIColor {
        return statusCode == "200" ? UIColor.systemGreen : UIColor.red
    }
    
    func transformToDetailModel() -> [DetailCellData] {
        let endpointType = DetailCellData(type: "api_endpoint", title: "API Endpoint", data: "\(self.httpVerb) \(self.endpoint)")
        let statusCodeType = DetailCellData(type: "api_status_code", title: "HTTP Status Code", data: self.statusCode)
        let baseURLType = DetailCellData(type: "api_base_url", title: "Base URL", data: self.baseURL)
        let queryParamsType = DetailCellData(type: "api_query_params", title: "Query Params", data: self.queryParams)
        let headersType = DetailCellData(type: "api_request_headers", title: "Request Headers", data: self.headers)
        let jsonResponse = DetailCellData(type: "api_response", title: "JSON Response", data: self.jsonResponse)
        let timestampType = DetailCellData(type: "api_timestamp", title: "Timestamp", data: self.timestamp)
        
        return [endpointType, statusCodeType, baseURLType, queryParamsType, headersType, timestampType, jsonResponse]
    }
}
