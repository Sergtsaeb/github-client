//
//  NetworkEngine.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/5/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import Foundation

protocol NetworkEngine {
    typealias Handler = (Data?, URLResponse?, Error?) -> ()
    
    func performRequest(for url: URL, completionHandler: @escaping Handler)
    
}

extension URLSession: NetworkEngine {
    typealias Handler = NetworkEngine.Handler
    
    func performRequest(for url: URL, completionHandler: @escaping Handler) {
        let task = dataTask(with: url, completionHandler: completionHandler)
        task.resume()
    }
    
}
