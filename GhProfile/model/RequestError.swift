//
//  RequestError.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import Foundation

enum RequestError: Error {
    case noData
}

extension RequestError {
    var isFatal: Bool {
        //TODO: Add more condition
        return true
    }
}

extension RequestError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noData:
            return "Request returns no data/invalid"
        default:
            return "Unexpected error occurred"
        }
    }
}
