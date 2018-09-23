//
//  PersonService.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

final class PersonService {
    
    var networkRequest = NetworkRequest()
    
    func performPersons(success: @escaping ((Bool, Data?) -> ()), failure: ((RequestError) -> ())?) {
        let url = API.createURL(endPoint: .fetchPerson)
        networkRequest.request(with: url, success: { (isSuccess, response) in
            success(isSuccess, response)
        }) { (error) in
            failure?(error)
        }
    }
}
