//
//  Defines.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

struct Defines {
    enum Messages: String {
        case NoInternetConnectionMessage = "The Internet connection appears to be offline."
        case UnknownError = "Something went wrong. Please, try again."
        case TimeOut = "Server is not reachable."
        case ErrorTitle = "ERROR!"
    }
    static let TimeOut = "err.timeout"
    static let UnauthorizedAccess = "unauthorized access"
    static let ErrorResponseKey = "error"
}
