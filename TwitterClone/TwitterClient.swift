//
//  TwitterClient.swift
//  TwitterClone
//
//  Created by LVMBP on 3/2/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterBaseURL = URL(string: "https://api.twitter.com")
let consumerKey = "b17DXyVaYgfqCFS5WoMYEAWJ7"
let consumerSecret = "LZMCfkCHbGDSfng1XLbP0dwq7DDLD0xhqebVVm5V1ofTOvmKfX"


class TwitterClient: BDBOAuth1SessionManager {
    static var sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: consumerKey, consumerSecret: consumerSecret)
    
    func getRequestToken(){
        fetchRequestToken(withPath: "oauth/request_token", method: "POST", callbackURL: URL(string: "vulongtwitterclone://"), scope: nil, success: { (response: BDBOAuth1Credential?) in
            if let response = response {
                let requestToken = response.token!
                let authURL = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken)")
                UIApplication.shared.open(authURL!, options: [:], completionHandler: nil)
            }
        }, failure:{(error: Error?) in
            print("\(error?.localizedDescription)")
        })
    }
    func getAccessToken(url: URL) -> Bool {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        var verified = false
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (response: BDBOAuth1Credential?) in
            if let response = response {
                print("Access token received \(response.token)")
                verified = true
                self.getCredentials()
                print("HERE COMES THE TWEETS=============")
                self.getTweet()
            }
        }, failure: { (error: Error?) in
            print("\(error.debugDescription)")
            verified = false
        })
        return verified
    }
    func getCredentials(){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response:Any?) in
            if let response = response {
//            print(response)
                let user = response as! NSDictionary
                print(user["name"] as! String)
                print(user["screen_name"] as! String)
                print(user["profile_image_url"] as! String)
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        })
    }
    func getTweet(){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) in
            if let response = response {
                let tweets = response as! [NSDictionary]
                
                for tweet in tweets {
                    print(tweet["text"] as! String)
                }
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
        })
    }
}
