//
//  feedCellTableViewCell.swift
//  SocialJournal
//
//  Created by James Garcia on 11/18/14.
//  Copyright (c) 2014 UH. All rights reserved.
//

import UIKit

class feedCellTableViewCell: UITableViewCell {
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var usernameBackground: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        usernameBackground.layer.masksToBounds = true
        usernameBackground.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 2.0
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
