//
//  RepositoryCell.swift
//  Github-Client
//
//  Created by Sergelenbaatar Tsogtbaatar on 4/5/17.
//  Copyright © 2017 Serg Tsogtbaatar. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoLanguageLabel: UILabel!
    
//    var repo: Repository! {
//        didSet {
//            self.repoNameLabel.text = repo.name
//            self.repoDescriptionLabel.text = repo.description
//            self.repoLanguageLabel.text = repo.language
//        }
//    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
