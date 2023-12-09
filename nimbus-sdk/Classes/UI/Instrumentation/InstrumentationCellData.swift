//
//  InstrumentationCellData.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

struct InstrumentationCellData {
    var uid: String
    var eventName: String
    var attributes: String
    var timestamp: Date
    
    func transformToDetailModel() -> [DetailCellData] {
        let eventNameType = DetailCellData(type: "instrument_event_name", title: "Event Name", data: self.eventName)
        let attributesType = DetailCellData(type: "instrument_attribute", title: "Attributes Data", data: self.attributes)
        let timestampType = DetailCellData(type: "instrument_timestamp", title: "Timestamp", data: self.timestamp.toFormattedDate())
        
        return [eventNameType, attributesType, timestampType]
    }
}
