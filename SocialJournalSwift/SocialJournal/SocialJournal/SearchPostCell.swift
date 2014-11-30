//
//  SearchPostCell.swift
//  SocialJournal
//
//  Created by Muhammad Naviwala on 11/29/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class SearchPostCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userProfilePicture: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.userProfilePicture.layer.cornerRadius = 50
//        self.userProfilePicture.layer.masksToBounds = true
//        self.userProfilePicture.layer.borderColor = UIColor.whiteColor().CGColor
//        self.userProfilePicture.layer.borderWidth = 1.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
