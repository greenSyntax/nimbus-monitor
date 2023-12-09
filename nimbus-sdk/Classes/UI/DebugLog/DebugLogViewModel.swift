//
//  DebugLogViewModel.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 06/09/23.
//

import Foundation

class DebugLogViewModel {
    
    var repository: CoreDataManager!
    
    init(repository: CoreDataManager!) {
        self.repository = repository
    }
    
    func getData(_ isBatch: Bool = false,
                      onCompletion: @escaping (_ result: Result<[LogDataModel], SDKError>) -> Void) {
        
        repository.read(entityName: SDKConstant.debugLogEntityName) { result in
            switch result {
            case .failure(let error):
                    onCompletion(.failure(error))
            case .success(let data):
                if let managedObjects = data as? [LogEntity] {
                    let transformedData = managedObjects.map({ object in
                        return LogDataModel(object)
                    })
                    onCompletion(.success(transformedData))
                }
            }
        }
    }
    
}
