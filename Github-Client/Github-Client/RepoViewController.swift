

//
//  RepoViewController.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/4/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class RepoViewController: UIViewController {

    var allRepos = [Repository]() {
        didSet {
            self.tableview.reloadData()
        }
    }
   
    var displayRepos: [Repository]? {
        didSet {
            self.tableview.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
        
        let repoNib = UINib(nibName: RepositoryCell.identifier, bundle: Bundle.main)
        self.tableview.register(repoNib, forCellReuseIdentifier: RepositoryCell.identifier)
        
        self.tableview.estimatedRowHeight = 100
        self.tableview.rowHeight = UITableViewAutomaticDimension
        
        self.searchBar.delegate = self
        self.tableview.delegate = self
        self.tableview.dataSource = self
        
    }
    
    func update() {
        GitHub.shared.getRepos { (repositories) in
        
            if let repositories = repositories {
                self.allRepos = repositories
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == RepoDetailViewController.identifier {
            segue.destination.transitioningDelegate = self
            
            if let selectedIndex = self.tableview.indexPathForSelectedRow?.row {
                let selectedRepo = self.allRepos[selectedIndex]
                
                if let destinationController = segue.destination as? RepoDetailViewController {
                    destinationController.destinationRepo = selectedRepo
                }
            }
        }
    }
}


//MARK: ViewControllerTrainsitioningDelegate
extension RepoViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CustomTransition(duration: 1.0)
    }
}

//MARK: TableView Extensions ---UITableViewDataSource, UITableViewDelegate---
extension RepoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        
        
        
        let repo = allRepos[indexPath.row]
        cell.repoNameLabel.text = repo.name
        cell.repoDescriptionLabel.text = repo.description
        cell.repoLanguageLabel.text = repo.language
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayRepos?.count ?? allRepos.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: RepoDetailViewController.identifier, sender: nil)
    }
    
}

//MARK: UISearchBarDelegate 
extension RepoViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.validate() {
            let lastIndex = searchText.index(before: searchText.endIndex)
            searchBar.text = searchText.substring(to: lastIndex)
        }
        
        if let searchedText = searchBar.text {
            self.displayRepos = self.allRepos.filter({$0.name.lowercased().contains(searchedText.lowercased())})
        }
        
        if searchBar.text == "" {
            self.displayRepos = nil
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.displayRepos = nil
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    
}
