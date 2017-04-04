//
//  GitHub.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/3/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

let kOAuthBaseURLString = "https://github.com/login/oauth/"

typealias GitHubOAuthCompletion = (Bool) -> ()

enum GibHubAuthError: Error {
    case extractingCode
    
}

enum SaveOptions {
    case userDefaults
}


class GitHub {
    
    
    static let shared = GitHub() //make singleton
    
    //takes in parameters to be able to see the oAuth
    func oAuthRequestWith(parameters: [String: String]) {
        var parametersString = ""
        
        // loop over key value pairings in parameter dictionary
        for (key, value) in parameters {
            parametersString += "&\(key)=\(value)"
        }
        
        print("Parameter String: \(parametersString)")
        
        //builds the whole url, the domain with a little bit of the URI
        //taking urls string and converting it to a URI, passing in the required client ID parameter at this endpoint
        if let requestURL = URL(string: "\(kOAuthBaseURLString)authorize?client_id=\(kGitHubClientID)\(parametersString)") {
            
            print(requestURL.absoluteString)
            
            UIApplication.shared.open(requestURL)
            
        }
    }
    
    func getCodeFrom(url: URL) throws -> String {
        
        guard let code = url.absoluteString.components(separatedBy: "=").last else {
            throw GibHubAuthError.extractingCode
        }
        
        return code
    }
    
    func tokenRequestFor(url: URL, saveOptions: SaveOptions, completion: @escaping GitHubOAuthCompletion) {
        func complete(success: Bool) {
            OperationQueue.main.addOperation { //returns on main queue with completion
                completion(success)
            }
        }
        
        do {
            let code = try self.getCodeFrom(url: url)
            
            let requestString = "\(kOAuthBaseURLString)access_token?client_id=\(kGitHubClientID)&client_secret=\(kGitHubClientSecret)&code=\(code)"
            //get string format from the docs
            
            if let requestURL = URL(string: requestString) {
                
                let session = URLSession(configuration: .default)
                
                session.dataTask(with: requestURL, completionHandler: { (data, response, error) in
                    
                    if error != nil { complete(success: false) }
                    
                    guard let data = data else { complete(success: false); return }
                    
                    if let dataString = String(data: data, encoding: .utf8) {
                        print(dataString)
                        
                        if UserDefaults.standard.save(accessToken: dataString) { print("Saved successfully") }
                        
                        complete(success: true)
                    }
                    
                    
                    
                    
                }).resume() //biggest error, need to tell the data task to resume manually or nothing will occur
            }
            
        } catch {
            print(error)
            complete(success: false)
        }
    }
    
    
}

