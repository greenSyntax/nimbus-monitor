//
//  InstrumentationDataModel.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation
import CoreData

class InstrumentationDataModel: ManagedObjectable {
    var uid: String
    var eventName: String
    var attributes: String
    var timestamp: Date
    
    var inBatch: Bool = false
    var entityName: String = SDKConstant.instrumentationEntityName
    
    init(uid: String, eventName: String, attributes: String, timestamp: Date) {
        self.uid = uid
        self.eventName = eventName
        self.attributes = attributes
        self.timestamp = timestamp
    }
    
    convenience init(_ contrcatType: InstrumentationLog) {
        self.init(uid: UUID().uuidString, eventName: contrcatType.eventName, attributes: contrcatType.attributes.toString(), timestamp: Date())
    }
    
    public init(_ object: InstrumentationEntity) {
        guard !object.isFault else {
            // When Coredata return Stale Data
            self.uid = "<fault>"
            self.eventName = "<fault>"
            self.attributes = "<fault>"
            self.timestamp = Date()
            return
        }
        
        self.uid = object.uid ?? "NA"
        self.eventName = object.eventName ?? "NA"
        self.attributes = object.attributes ?? "NA"
        self.timestamp = object.timestamp ?? Date()
    }
    
    func toCellData() -> InstrumentationCellData {
        return InstrumentationCellData(uid: self.uid, eventName: self.eventName, attributes: self.attributes, timestamp: self.timestamp)
    }
    
    func toManagedObject() -> NSManagedObject {
        let object = InstrumentationEntity()
        object.uid = UUID().uuidString
        object.eventName = self.eventName
        object.attributes = self.attributes
        object.timestamp = self.timestamp
        
        return object as! NSManagedObject
    }
    
    func fromManagedObject(_ managedObj: NSManagedObject) {
        managedObj.setValue(self.uid, forKey: "uid")
        managedObj.setValue(self.eventName, forKey: "eventName")
        managedObj.setValue(self.attributes, forKey: "attributes")
        managedObj.setValue(self.timestamp, forKey: "timestamp")
    }
    
    
}
