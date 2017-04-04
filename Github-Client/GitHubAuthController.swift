//
//  GitHubAuthController.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/3/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class GitHubAuthController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateButton()
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    func updateButton() {
        if UserDefaults.standard.getAccessToken() == nil {
            print("Please log in.")
            loginButton.isEnabled = true
            loginButton.isHidden = false
        } else {
            print("Already logged in.")
            loginButton.isHidden = true
            loginButton.isEnabled = false
        }
        
    }
    

    @IBAction func printTokenPressed(_ sender: Any) {
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        updateButton()
        let parameters = ["scope":"email,user"]
        GitHub.shared.oAuthRequestWith(parameters: parameters)
        
    }
    
}
