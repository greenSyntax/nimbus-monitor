//
//  NBDate.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 06/09/23.
//

import Foundation

extension Date {
    
    func toFormattedDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "d MMM YYYY, h:mm a"
        return df.string(from: self)
    }
    
}

extension Dictionary {
    func toString() -> String {
        return (self.compactMap({ (key, value) -> String in
            return "\(key) = \(value)"
        }) as Array).joined(separator: "\n")
    }
}
