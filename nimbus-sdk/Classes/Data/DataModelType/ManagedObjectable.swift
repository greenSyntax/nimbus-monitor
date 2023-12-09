//
//  ManagedObjectable.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation
import CoreData

protocol ManagedObjectable {
    var inBatch: Bool { get set }
    var entityName: String { get set }
    
    func toManagedObject() -> NSManagedObject
    func fromManagedObject(_ managedObj: NSManagedObject)
}
