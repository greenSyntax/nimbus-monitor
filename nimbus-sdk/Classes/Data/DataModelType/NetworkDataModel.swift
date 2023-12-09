//
//  NetworkDataModel.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation
import CoreData

class NetworkDataModel: ManagedObjectable {
    var uid: String
    var baseURL: String
    var endpoint: String
    var headers: String
    var httpVerb: String
    var jsonResponse: String
    var queryParams: String
    var statusCode: String
    var timestamp: Date
    
    var inBatch: Bool = false
    var entityName: String = SDKConstant.networkEntityName
    
    init(baseURL: String, endpoint: String, headers: String, httpVerb: String, jsonResponse: String, queryParams: String, statusCode: String) {
        self.uid = UUID().uuidString
        self.baseURL = baseURL
        self.endpoint = endpoint
        self.headers = headers
        self.httpVerb = httpVerb
        self.jsonResponse = jsonResponse
        self.queryParams = queryParams
        self.statusCode = statusCode
        self.timestamp = Date()
    }
    
    convenience init(_ contrcatType: NetworkLog) {
        self.init(baseURL: contrcatType.baseURL, endpoint: contrcatType.endpoint, headers: contrcatType.headers.toString(), httpVerb: contrcatType.httpVerb, jsonResponse: (contrcatType.jsonRepsonse.prettyPrintedJSON ?? "NA") as String, queryParams: contrcatType.queryParams.toString(), statusCode: contrcatType.statusCode)
    }
    
    public init(_ object: NetworkEntity) {
        guard !object.isFault else {
            // When Coredata return Stale Data
            self.uid = "<fault>"
            self.baseURL = "<fault>"
            self.endpoint = "<fault>"
            self.headers = "<fault>"
            self.httpVerb = "<fault>"
            self.jsonResponse = "<fault>"
            self.queryParams = "<fault>"
            self.statusCode = "<fault>"
            self.timestamp = Date()
            return
        }
        
        self.uid = object.uid ?? "NA"
        self.baseURL = object.baseURL ?? "NA"
        self.endpoint = object.endpoint ?? "NA"
        self.headers = object.headers ?? "NA"
        self.httpVerb = object.httpVerb ?? "NA"
        self.jsonResponse = object.jsonRepsonse ?? "NA"
        self.queryParams = object.queryParams ?? "NA"
        self.statusCode = object.statusCode ?? "NA"
        self.timestamp = object.timestamp ?? Date()
        
    }
    
    func toCellData() -> NetworkCellData {
        return NetworkCellData(uid: self.uid, baseURL: self.baseURL, endpoint: self.endpoint, headers: self.headers, httpVerb: self.httpVerb, jsonResponse: self.jsonResponse, queryParams: self.queryParams, statusCode: self.statusCode, timestamp: self.timestamp.toFormattedDate())
    }
    
    func fromManagedObject(_ managedObj: NSManagedObject) {
        managedObj.setValue(self.uid, forKey: "uid")
        managedObj.setValue(self.baseURL, forKey: "baseURL")
        managedObj.setValue(self.endpoint, forKey: "endpoint")
        managedObj.setValue(self.headers, forKey: "headers")
        managedObj.setValue(self.httpVerb, forKey: "httpVerb")
        managedObj.setValue(self.jsonResponse, forKey: "jsonRepsonse")
        managedObj.setValue(self.queryParams, forKey: "queryParams")
        managedObj.setValue(self.statusCode, forKey: "statusCode")
        managedObj.setValue(self.timestamp, forKey: "timestamp")
    }
    
    func toManagedObject() -> NSManagedObject {
        let networkManagedObject = NetworkEntity()
        networkManagedObject.uid = UUID().uuidString
        networkManagedObject.baseURL = self.baseURL
        networkManagedObject.endpoint = self.endpoint
        networkManagedObject.headers = self.headers
        networkManagedObject.httpVerb = self.httpVerb
        networkManagedObject.jsonRepsonse = self.jsonResponse
        networkManagedObject.queryParams = self.queryParams
        networkManagedObject.statusCode = self.statusCode
        networkManagedObject.timestamp = self.timestamp
        
        return networkManagedObject as! NSManagedObject
    }
    
}
