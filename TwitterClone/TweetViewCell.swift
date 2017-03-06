//
//  TweetViewCell.swift
//  TwitterClone
//
//  Created by LVMBP on 3/3/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit

class TweetViewCell: UITableViewCell {
    let like_on = UIImage(named: "like_on")
    let like_off = UIImage(named: "like_off")
    let retweet_on = UIImage(named: "retweet_on")
    let retweet_off = UIImage(named: "retweet_off")
    var like_status: Bool?
    var retweet_status: Bool?

    @IBOutlet weak var retweetStatusImg: UIImageView!
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var retweetStatusLabel: UILabel!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var accNameLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var replyImg: UIImageView!
    @IBOutlet weak var retweetImg: UIImageView!
    @IBOutlet weak var likeImg: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            displayNameLabel.text = tweet.user?.name
            accNameLabel.text = "@\(tweet.user?.screenname!)"
            timeAgoLabel.text = tweet.timeSince
            if (tweet.user?.profileUrl != nil) {
                avatarImg.setImageWith((tweet.user?.profileUrl)!)
            }
            if ((tweet.retweeted ?? false) == true){
                retweetStatusLabel.text = "This is a retweeted"
            }
            else{
                retweetStatusLabel.text = "Original tweet"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let likeGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeClicked(likeGestureRecognizer:)))
        likeImg.isUserInteractionEnabled = true
        likeImg.addGestureRecognizer(likeGestureRecognizer)

        let retweetGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(retweetClicked(retweetGestureRecognizer:)))
        retweetImg.isUserInteractionEnabled = true
        retweetImg.addGestureRecognizer(retweetGestureRecognizer)
        
    }
    func likeClicked(likeGestureRecognizer: UITapGestureRecognizer)
    {
        print("like clicked")
        like_status = !(like_status ?? false)
        if(like_status == true){
            likeImg.image = like_on
        } else {
            likeImg.image = like_off
        }
        
    }
    func retweetClicked(retweetGestureRecognizer: UITapGestureRecognizer)
    {
        print("retweet clicked")
        retweet_status = !(retweet_status ?? false)
        if(retweet_status == true){
            retweetImg.image = #imageLiteral(resourceName: "retweet_on")
        } else {
            retweetImg.image = #imageLiteral(resourceName: "retweet_off")
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
