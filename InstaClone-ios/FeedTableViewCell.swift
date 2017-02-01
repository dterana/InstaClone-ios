//
//  FeedTableViewCell.swift
//  InstaClone-ios
//
//  Created by Pourpre on 2/1/17.
//  Copyright © 2017 Pourpre. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    
    
    //--------------------------------------
    //MARK: - IBOutlet declaration
    //--------------------------------------
    
    @IBOutlet weak var postedImage: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!

    @IBOutlet weak var messageLbl: UILabel!
    
    
    //--------------------------------------
    //MARK: - Override Function declaration
    //--------------------------------------
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
