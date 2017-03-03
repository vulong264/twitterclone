//
//  TweetViewCell.swift
//  TwitterClone
//
//  Created by LVMBP on 3/3/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {


    @IBOutlet weak var retweetStatusImg: UIImageView!
    @IBOutlet weak var replyImg: UIImageView!
    @IBOutlet weak var retweetImg: UIImageView!
    @IBOutlet weak var starImg: UIImageView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var retweetStatusLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var accNameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
