//
//  HomeViewController.swift
//  TwitterClone
//
//  Created by LVMBP on 3/3/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBAction func onLogout(_ sender: UIBarButtonItem) {
        TwitterClient.sharedInstance?.logout()
    }
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    var refreshControl = UIRefreshControl()
    var selectedTweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension

        // set up the refresh control
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)
        self.tableView?.addSubview(refreshControl)
        
        self.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadData(){
        TwitterClient.sharedInstance?.getTweets(success: { (return_tweets: [Tweet]?) in
            if let tweets = return_tweets {
                self.tweets = tweets
//                print(tweets)
                self.tableView.reloadData()
                if self.refreshControl.isRefreshing
                {
                    self.refreshControl.endRefreshing()
                }

            }
        }, failure: {(error: Error) -> () in
            print("ERROR: \(error.localizedDescription)")
        })
//            TwitterClient.sharedInstance?.getTweets()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func pullToRefresh(refreshControl: UIRefreshControl) {
        reloadData()
    }

}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, NewTweetViewControllerDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets == nil {
            return 0
        } else {
            return tweets.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterViewCell") as! TweetViewCell
        cell.tweet = tweets[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTweet = tweets[indexPath.row] 
        performSegue(withIdentifier: "ViewTweetSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "ViewTweetSegue"){
            let nextVC = segue.destination as! TweetViewController
            nextVC.tweet = selectedTweet
        }

        if(segue.identifier == "NewTweet"){
            let nextVC = segue.destination as! NewTweetViewController
            nextVC.delegate = self
        }        
    }
    
    func addingNewTweet(newVC: NewTweetViewController, tweet: NSDictionary) {
        print("~~~~~~~~~~~~Posted new tweet: \(tweet)")

        let newTweet = Tweet.init(dictionary: tweet)
        self.tweets.insert(newTweet, at: 0)
        self.tableView.reloadData()
    }
}
