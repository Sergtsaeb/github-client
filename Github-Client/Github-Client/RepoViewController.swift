//
//  RepoViewController.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/4/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController, UISearchBarDelegate {

    var allRepos = [Repository]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableview.delegate = self
        self.tableview.dataSource = self
        update()
    }
    
    func update() {
        GitHub.shared.getRepos { (repositories) in
        
            if let repositories = repositories {
                self.allRepos = repositories
                self.tableview.reloadData()
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}

//MARK: TableView Extensions ---UITableViewDataSource, UITableViewDelegate---
extension RepoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RepoTableCell
        cell.nameLabel.text = allRepos[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRepos.count
    }
    
}
