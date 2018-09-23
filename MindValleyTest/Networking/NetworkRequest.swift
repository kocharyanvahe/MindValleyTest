//
//  NetworkRequest.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

final class NetworkRequest: NSObject {
    
    func request(with url: URL, success: @escaping ((Bool, Data?) -> ()), failure: ((RequestError) -> ())?) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let error = responseError {
                    let errorText = error.localizedDescription
                    let errorCode = (error as NSError).code
                    success(false, nil)
                    failure?(RequestError.checkError(errorText, errorCode: errorCode))
                } else if let jsonData = responseData {
                    success(true, jsonData)
                }
            }
        }
        task.resume()
    }
}
