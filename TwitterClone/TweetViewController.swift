//
//  TweetViewController.swift
//  TwitterClone
//
//  Created by LVMBP on 3/3/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    let like_on = UIImage(named: "like_on")
    let like_off = UIImage(named: "like_off")
    let retweet_on = UIImage(named: "retweet_on")
    let retweet_off = UIImage(named: "retweet_off")
    var like_status: Bool?
    var retweet_status: Bool?
    @IBOutlet weak var likeImg: UIImageView!
    @IBOutlet weak var retweetImg: UIImageView!
    @IBOutlet weak var replyImg: UIImageView!
    @IBOutlet weak var userAvatarImg: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var accNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetTimeLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var tweetFavorLabel: UILabel!
    var tweet: Tweet?
    override func viewDidLoad() {
        super.viewDidLoad()
        if (tweet?.user?.profileUrl != nil) {
            userAvatarImg.setImageWith((tweet?.user?.profileUrl)!)
        }
        screenNameLabel.text = tweet?.user?.name
        accNameLabel.text = "@\(tweet?.user?.screenname!)"
        tweetTextLabel.text = tweet?.text
        tweetCountLabel.text = "\(tweet?.retweet_count ?? 0)"
        tweetFavorLabel.text = "\(tweet?.favorite_count ?? 0)"
        tweetTimeLabel.text = "\(tweet?.tweet_created_at)"
        // Do any additional setup after loading the view.
        
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
    @IBAction func goHome(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
