//
//  TimeLineTableViewCell.swift
//  InstagramSmple
//
//  Created by 藤井鈴菜 on 2019/08/11.
//  Copyright © 2019 藤井鈴菜. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {
    
    @IBOutlet var userImageView : UIImageView!
    
    @IBOutlet var userNameLabel : UILabel!
    
    @IBOutlet var userIdLabel : UILabel!
    
    @IBOutlet var timeStampLabel : UILabel!
    
    @IBOutlet var tweetTextView : UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
        userImageView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
