//
//  LogDataMode.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 31/08/23.
//

import Foundation
import CoreData

public struct LogDataModel: ManagedObjectable {
    var inBatch: Bool = false
    var entityName: String = SDKConstant.debugLogEntityName
    
    var logId: String
    var tag: String
    var title: String
    var body: String
    var timestamp: Date
    
    public init(_ tag: String, _ title: String, _ body: String) {
        self.logId = UUID().uuidString
        self.tag = tag
        self.title = title
        self.body = body
        self.timestamp = Date()
    }
    
    init(_ contractType: Log) {
        self.init(contractType.tag, contractType.title, contractType.body)
    }
    
    public init(_ object: LogEntity) {
        guard !object.isFault else {
            self.logId = "<fault>"
            self.tag = "<fault>"
            self.title = "<fault>"
            self.body = "<fault>"
            self.timestamp = Date()
            return
        }
        self.logId = object.logId ?? "NA"
        self.tag = object.tag ?? "NA"
        self.title = object.title ?? "NA"
        self.body = object.body ?? "NA"
        self.timestamp = object.timestamp ?? Date()
    }
    
    func toCellData() -> LogViewCellData {
        return LogViewCellData(uid: self.logId, tag: self.tag, title: self.title, description: self.body, timestamp: self.timestamp)
    }
    
    func fromManagedObject(_ managedObj: NSManagedObject) {
        managedObj.setValue(self.logId, forKey: "logId")
        managedObj.setValue(self.tag, forKey: "tag")
        managedObj.setValue(self.title, forKey: "title")
        managedObj.setValue(self.body, forKey: "body")
        managedObj.setValue(self.timestamp, forKey: "timestamp")
    }

    func toManagedObject() -> NSManagedObject {
        let logManagedObject = LogEntity()
        logManagedObject.logId = UUID().uuidString
        logManagedObject.tag = self.tag
        logManagedObject.title = self.title
        logManagedObject.body = self.body
        logManagedObject.timestamp = self.timestamp
        
        return logManagedObject as! NSManagedObject
    }
    
}
