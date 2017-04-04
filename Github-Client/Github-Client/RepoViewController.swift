//
//  RepoViewController.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/4/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        update()
       
    }
    
    func update() {
        print("Update repo controller here")
        
        GitHub.shared.getRepos { (repositories) in
            
            print(repositories?.first)
            //update tableView
        }
    }


}
