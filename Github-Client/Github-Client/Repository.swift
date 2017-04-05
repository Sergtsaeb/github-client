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
    let description: String?
    let language: String?
    
    init?(json: [String:Any]) {
        
                guard let name = json["name"] as? String else { return nil }
                let description = json["description"] as? String
                let language = json["language"] as? String
                
                self.name = name
                self.description = description
                self.language = language
        
        }
    }
    
