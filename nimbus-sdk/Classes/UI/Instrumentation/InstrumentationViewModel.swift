//
//  InstrumentationViewModel.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

struct InstrumentationViewModel {
    var repository: CoreDataManager
    
    init(repository: CoreDataManager) {
        self.repository = repository
    }
    
    func getData(_ isBatch: Bool = false,
                      onCompletion: @escaping (_ result: Result<[InstrumentationDataModel], SDKError>) -> Void) {
        
        repository.read(entityName: SDKConstant.instrumentationEntityName) { result in
            switch result {
            case .failure(let error):
                    onCompletion(.failure(error))
            case .success(let data):
                if let managedObjects = data as? [InstrumentationEntity] {
                    let transformedData = managedObjects.map({ object in
                        return InstrumentationDataModel(object)
                    })
                    onCompletion(.success(transformedData))
                }
            }
        }
    }
    
}
