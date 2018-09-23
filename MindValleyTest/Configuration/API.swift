//
//  API.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

struct API {
    static let scheme = "http"
    static let host = "pastebin.com"
    
    enum Endpoint {
        case fetchPerson
        
        var endpoint: String {
            switch self {
            case .fetchPerson:
                return "/raw/wgkJgazE"
            }
        }
    }
    
    static func createURL(endPoint: Endpoint) -> URL {
        var urlComponent = URLComponents()
        urlComponent.scheme = scheme
        urlComponent.host = host
        urlComponent.path = endPoint.endpoint
        guard let url = urlComponent.url else {
            fatalError("Error with creation of url.")
        }
        return url
    }
}
