//
//  ErrorHandling.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case NoInternetConnection
    case TimeOut
    case UnknownError
    
    static func checkError(_ errorMessage: String?, errorCode: Int) -> RequestError {
        switch errorCode {
        case -1009, -1005:
            return RequestError.NoInternetConnection
        case 408:
            if errorMessage == Defines.TimeOut {
                return RequestError.TimeOut
            } else {
                return RequestError.UnknownError
            }
        default:
            return RequestError.UnknownError
        }
    }
}
