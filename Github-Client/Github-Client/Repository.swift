//
//  Repository.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/4/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import Foundation

class Repository {
   
    let name: String
    let description: String
    let language: String?
    var numStars: Int? = 0
    let isForked: Bool
    let createDate: String
    let repoUrlString: String
    
    init?(json: [String: Any]) {
        
        self.name = json["name"] as! String
        self.description = json["description"] as? String ?? "No description"
        self.language = json["language"] as? String
        
        if let numStar = json["stargazers_count"] as? Int {
            self.numStars = numStar
        }
        
        
        self.isForked = json["fork"] as! Bool
        self.createDate = json["created_at"] as! String
        
        self.repoUrlString = json["html_url"] as? String ?? "https://github.com"
 
    
    }
}

