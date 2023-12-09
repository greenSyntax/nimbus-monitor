//
//  NimbusService.swift
//  nimbus-sdk
//
//  Created by Abhishek Ravi on 31/08/23.
//

import Foundation

public enum LogType {
    case debug(Log)
    case network(NetworkLog)
    case instrumentation(InstrumentationLog)
}

public class NimbussService {
    
    private lazy var dataLayer: CoreDataManager = {
        return CoreDataManager()
    }()
    
    private var showConsoleLogs: Bool
    
    public init(_ showConsoleLogs: Bool = false) {
        self.showConsoleLogs = showConsoleLogs
    }
    
    public func write(_ data: LogType) {
        let managedObject: ManagedObjectable?
        
        switch data {
        case .debug(let log):
            managedObject = LogDataModel(log.tag, log.title, log.body)
        case .network(let log):
            managedObject = NetworkDataModel(log)
        case .instrumentation(let log):
            managedObject = InstrumentationDataModel(log)
        }
        
        guard let obj = managedObject else { return }
        dataLayer.write(obj) { result in
            switch result {
            case .failure(let error):
                print(error.message)
            case .success(let isWritten):
                if self.showConsoleLogs {
                    print("✅ Successfully Written: \(isWritten)")
                }
            }
        }
    }
    
    public func read(entity: String) {
        dataLayer.read(entityName: entity) { result in
            if self.showConsoleLogs { return }
            switch result {
            case .failure(let error):
                print("❌ NimbusSDK Error: \(error.message)")
            case .success(let data):
                if let managedObject = data as? [LogEntity] {
                    print("✅ Log Entity: \(managedObject.count)")
                } else if let managedObject = data as? [NetworkEntity] {
                    print("✅ Network Entity: \(managedObject.count)")
                } else if let managedObject = data as? [InstrumentationEntity] {
                    print("✅ Instrumentation Entity: \(managedObject.count)")
                }
            }
        }
    }
    
    public func delete(_ logId: String) {
        //TODO:
    }
    
    public func deleteDebugLogs() {
        dataLayer.clear(SDKConstant.debugLogEntityName)
    }
    
    public func deleteNetworkLogs() {
        dataLayer.clear(SDKConstant.networkEntityName)
    }
    
    public func deleteInstrumentationLogs() {
        dataLayer.clear(SDKConstant.instrumentationEntityName)
    }
    
}

extension NimbussService {
    
    /// Nimbus ViewController Will be presented when you shake
    public func monitor() {
        NotificationCenter.default.addObserver(self, selector: #selector(shakeDetected), name: UIDevice.deviceDidShakeNotification, object: nil)
    }
    
    /// Get Nimbus ViewController If you want to place at cenrtain position of your app
    /// - Returns: NimbusViewController
    public func getNimbusViewController() -> NimbusViewController {
        return createNimbusViewController()
    }
    
    @objc private func shakeDetected() {
        launchNimbus()
    }
    
    private func launchNimbus() {
        let topVC = UIApplication.shared.keyWindow?.viewControllerInStack()
        if !(topVC is NimbusViewController) {
            let nimbusVC = createNimbusViewController()
            
            if let navVC = topVC as? UINavigationController {
                if let nv = navVC.viewControllers.last?.presentedViewController as? UINavigationController {
                    if let vc = nv.viewControllers.last {
                        vc.present(nimbusVC, animated: true)
                    }
                } else if let vc = navVC.viewControllers.last {
                    vc.present(nimbusVC, animated: true)
                }
            } else {
                topVC?.present(nimbusVC, animated: true)
            }
        }
    }
    
    private func createNimbusViewController() -> NimbusViewController {
        let nimbusController = NimbusViewController()
        nimbusController.service = self
        return nimbusController
    }
}
