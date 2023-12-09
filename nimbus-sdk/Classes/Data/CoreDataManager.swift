//
//  CoreDataManager.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 31/08/23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    private let batchSize: Int
    private lazy var context = persistentContainer.viewContext
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: SDKConstant.databaseName, managedObjectModel: managedObjectModel)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("❌ Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle(for: CoreDataManager.self).url(forResource: SDKConstant.databaseName, withExtension: "momd")!
        print("🏀 MOMD URL: \(modelURL)")
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    init(_ batchSize: Int = 5) {
        self.batchSize = batchSize
    }
    
    func read(entityName: String, onCompletion: @escaping (_ result: Result<[NSManagedObject]?, SDKError>) -> Void) {
        persistentContainer.performBackgroundTask { [weak self] (context) in
            guard let self = self else { return }
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fetchRequest.returnsObjectsAsFaults = false
            let sort = NSSortDescriptor(key: "timestamp", ascending: false)
            fetchRequest.sortDescriptors = [sort]
            do {
                let result = try context.fetch(fetchRequest) as? [NSManagedObject]
                onCompletion(.success(result))
            } catch {
                onCompletion(.failure(.error(error)))
            }
        }
    }
    
    func write(_ log: ManagedObjectable, onCompletion: @escaping (_ result: Result<Bool, SDKError>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: log.entityName, in: persistentContainer.viewContext) else {
            onCompletion(.failure(.writeFailure))
            return
        }
        persistentContainer.performBackgroundTask { (context) in
            let logObj = NSManagedObject(entity: entity, insertInto: context)
            log.fromManagedObject(logObj)
            
            do {
                try context.save()
                onCompletion(.success(true))
            } catch {
                onCompletion(.failure(.error(error)))
            }
        }
    }
    
    func update(_ oldEvent: LogDataModel, _ newDataModel: LogDataModel) {
        //TODO:
    }
    
    func delete(_ logs: [LogDataModel], onCompletion: ((_ result: Result<Bool, SDKError>) -> Void)? = nil) {
        
        func deleteFromCoreData(_ logId: String) {
            do {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: SDKConstant.debugLogEntityName)
                fetchRequest.predicate = NSPredicate(format: "logId == %@", logId)
                if let data = try? context.fetch(fetchRequest).first as? NSManagedObject {
                    self.persistentContainer.viewContext.delete(data)
                    try self.persistentContainer.viewContext.save()
                    onCompletion?(.success(true))
                } else {
                    onCompletion?(.failure(.failedOnDelete))
                }
            } catch {
                onCompletion?(.failure(.error(error)))
            }
        }
        
        let logIds = logs.compactMap({ $0.logId })
        logIds.forEach { logId in
            deleteFromCoreData(logId)
        }
    }
    
    //TODO: Need to refactor
    func clear(_ entity: String) {
        persistentContainer.performBackgroundTask { [weak self] (context) in
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
            do {
                try context.execute(deleteRequest)
                print("Successfully Delete All Data for \(entity)")
            }
            catch {
                print(error)
                print("Error on Delete All Data for \(entity)")
            }
        }
    }
}
    
