//
//  DebugLOgBuilder.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 06/09/23.
//

import Foundation

final class DebugLogBuilder {
    
    static func build() -> DebugLogsViewController {
        let vc = DebugLogsViewController()
        let dataRepository = CoreDataManager()
        vc.viewModel = DebugLogViewModel(repository: dataRepository)
        return vc
    }
    
}
