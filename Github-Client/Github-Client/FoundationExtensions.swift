//
//  FoundationExtensions.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/3/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    //extension to get access to token if available and save 
    
    func getAccessToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: "access_token") else { return nil }
        return token
    }
    
    func save(accessToken: String) -> Bool {
        UserDefaults.standard.set(accessToken,forKey: "access_token")
        return UserDefaults.standard.synchronize()
    }
    
}
