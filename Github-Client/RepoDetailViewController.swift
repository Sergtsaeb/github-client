//
//  RepoDetailViewController.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/5/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit
import SafariServices

class RepoDetailViewController: UIViewController {
    
    var destinationRepo: Repository!
    
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var numberOfStars: UILabel!
    @IBOutlet weak var isFork: UILabel!
    @IBOutlet weak var createdDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpDetails()
    }

    func setUpDetails() {
        self.repoName.text = destinationRepo.name
        self.repoDescription.text = destinationRepo.description
        self.language.text = destinationRepo.language
        self.numberOfStars.text = String(describing: destinationRepo.numStars)
        self.isFork.text = destinationRepo.isForked ? "Forked" : "Unforked"
        self.createdDate.text = destinationRepo.createDate
    }

    @IBAction func moreDetailsPressed(_ sender: Any) {
        guard let repo = destinationRepo else { return }
        
        presentWebViewControllerWith(urlString: repo.repoUrlString)
//        presentSafariViewControllerWith(urlString: repo.repoUrlString)
    }
    
//    func presentSafariViewControllerWith(urlString: String) {
//        
//        guard let url = URL(string: urlString) else {return}
//        let safariController = SFSafariViewController(url: url)
//        self.present(safariController, animated: true, completion: nil)
//        
//    }
    
    func presentWebViewControllerWith(urlString: String) {
        let webController = WebViewController()
        webController.url = urlString
        self.present(webController, animated: true, completion: nil)
    }
    
}
