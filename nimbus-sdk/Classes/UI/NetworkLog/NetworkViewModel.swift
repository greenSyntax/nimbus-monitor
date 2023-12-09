//
//  NetworkViewModel.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

class NetworkViewModel {
    
    var repository: CoreDataManager!
    
    init(repository: CoreDataManager!) {
        self.repository = repository
    }
    
    func getData(onCompletion: @escaping (_ result: Result<[NetworkDataModel], SDKError>) -> Void) {
        
        repository.read(entityName: SDKConstant.networkEntityName) { result in
            switch result {
            case .failure(let error):
                    onCompletion(.failure(error))
            case .success(let data):
                if let managedObjects = data as? [NetworkEntity] {
                    let transformedData = managedObjects.map({ object in
                        return NetworkDataModel(object)
                    })
                    onCompletion(.success(transformedData))
                }
            }
        }
    }
    
}
