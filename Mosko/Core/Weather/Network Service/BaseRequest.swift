//
//  BaseRequest.swift
//  mosko
//
//  Created by Deven Nathanael on 19/12/21.
//

import Foundation

class BaseRequest: NSObject {
    static func GET(
        url: String,
        completionHandler: @escaping (Any) -> Void
    ) {
        guard let safeUrl = URL(string: url) else { return }
        
        var request = URLRequest(url: safeUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        // MARK: Initialize Session
        let session = URLSession.shared
        
        // MARK: Initialize DataTask
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print(error as Any)
            } else if let dataFromAPI = data {
                completionHandler(dataFromAPI)
            }
        }
        dataTask.resume()
    }
    
    static func GET(url: String, header: [String: String], showLoader: Bool, completionHandler: @escaping (Any) -> Void) {
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        // MARK: Configure Request Method and Set Header
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header
        
        // MARK: Initialize Session
        let session = URLSession.shared
        
        // MARK: Initialize DataTask
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if (error != nil) {
                print(error as Any)
            } else {
                if let dataFromAPI = data {
                    completionHandler(dataFromAPI)
                }
            }
        }
        dataTask.resume()
    }
}
