//
//  NBApplication.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 06/09/23.
//

import Foundation

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionBegan(motion, with: event)
        guard motion == UIEvent.EventSubtype.motionShake else { return }

        NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
    }
}
