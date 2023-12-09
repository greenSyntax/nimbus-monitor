//
//  SDKError.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 31/08/23.
//

import Foundation

public enum SDKError: Error {
    case writeFailure
    case readFailure
    case typeCastFailure
    case failedOnDelete
    case serverError
    case noHTTPData
    case error(Error)
    case custom(String)
    
    public var message: String {
        switch self {
        case .readFailure:
            return "Failed while loading the Data from Db"
        case .writeFailure:
            return "Failed while writing data to Db"
        case .error(let err):
            return err.localizedDescription
        case .custom(let message):
            return message
        case .failedOnDelete:
            return "CoreData Delete Failure"
        case .typeCastFailure:
            return "CoreData Data Model is not matching with the Type"
        case .serverError:
            return "Check your API Server or API Payload Validation"
        case .noHTTPData:
            return "No HTTP Data in Body"
        }
    }
}
