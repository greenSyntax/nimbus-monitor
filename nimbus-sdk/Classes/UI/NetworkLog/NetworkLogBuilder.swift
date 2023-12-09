//
//  NetworkLogBuilder.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

final class NetworkLogBuilder {
    
    static func build() -> NetworkLogsViewController {
        let vc = NetworkLogsViewController()
        let dataRepository = CoreDataManager()
        vc.viewModel = NetworkViewModel(repository: dataRepository)
        return vc
    }
    
}
