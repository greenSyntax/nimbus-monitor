//
//  DebugCellData.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

struct LogViewCellData {
    var uid: String
    var tag: String
    var title: String
    var description: String
    var timestamp: Date
    
    var tagColor: UIColor {
        switch tag {
        case "debug":
            return .systemGreen
        case "error":
            return .red
        case "info":
            return .purple
        default:
            return .darkGray
        }
    }
    
    func transformToDetailModel() -> [DetailCellData] {
        let logType = DetailCellData(type: "log_type", title: "Type", data: self.tag)
        let logTimestamp = DetailCellData(type: "log_timestamp", title: "Timestamp", data: self.timestamp.toFormattedDate())
        let logTitle = DetailCellData(type: "log_title", title: "Title", data: self.title)
        let logDescription = DetailCellData(type: "log_description", title: "Description", data: self.description)
        
        return [logType, logTimestamp, logTitle, logDescription]
    }
}
