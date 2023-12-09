//
//  InstrumentationLogBuilder.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

final class InstrumentationLogBuilder {
    
    static func build() -> InstrumentationViewController {
        let vc = InstrumentationViewController()
        let dataRepository = CoreDataManager()
        vc.viewModel = InstrumentationViewModel(repository: dataRepository)
        return vc
    }
    
}
