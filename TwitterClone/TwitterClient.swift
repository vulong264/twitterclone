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
//    var accessToken = ""
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    func getRequestToken(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        deauthorize()
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
    func getAccessToken(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (response: BDBOAuth1Credential?) in
            if let response = response {
                print("Access token received \(response.token)")
                
                self.getCredentials(success: { (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: {(error: Error) -> () in
                    self.loginFailure?(error)
                })
                
//                self.accessToken = response.token
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.displayHomeScreen()
            }
        }, failure: { (error: Error?) in
            print("\(error.debugDescription)")
            
        })
    }

    func getCredentials(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response:Any?) in
            if let response = response {
//            print(response)
                let userDictionary = response as! NSDictionary
                print(userDictionary["name"] as! String)
                print(userDictionary["screen_name"] as! String)
                print(userDictionary["profile_image_url"] as! String)
                let user = User(dictionary: userDictionary)
                
                success(user)
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure(error)
        })
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: User.userDidLogOutNotification), object: nil)
    }
    func getTweets(success: @escaping ([Tweet]) -> () ,failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) in
            if let response = response {
//                    print(response)
                let tweets_dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries: tweets_dictionaries)
//                print(tweets)
                success(tweets)
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure(error)
        })
    }
    
    func postTweet(tweet: String!, success: @escaping (NSDictionary) -> () ,failure: @escaping (Error) -> ()){
//        https://api.twitter.com/1.1/statuses/update.json

        let originalString = tweet!
        let escapedString = originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        print(escapedString!)

        let endPointWithVar = "1.1/statuses/update.json?status=\(escapedString!)"
        print(endPointWithVar)
//        let urlString :String = endPointWithVar.replacingOccurrences(of: " ", with: "%20")

//        print(urlString)
        
        post(endPointWithVar,parameters: nil, progress: nil, success: { (task: URLSessionDataTask?, response: Any?) in
            if let response = response {
                success(response as! NSDictionary)
            }
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print(error.localizedDescription)
            failure(error)
        })
    }
}
