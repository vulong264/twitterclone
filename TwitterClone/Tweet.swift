//
//  Tweet.swift
//  TwitterClone
//
//  Created by LVMBP on 3/4/17.
//  Copyright © 2017 vulong. All rights reserved.
//
import UIKit

class Tweet: NSObject {
    
    var text: String?
    var tweet_created_at: Date?
    var time: String?
    var timeSince: String!
    var favoritesCount: Int?
    var retweet_count: Int?
    var retweeted: Bool!
    var favorite_count: Int!
    var id: String!
    var user: User?
    var retweeter: Tweet!
    var timeInInt: Int?
    
    init(dictionary: NSDictionary){
        id = dictionary["id_str"] as? String
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweeted = dictionary["retweeted"] as? Bool
        retweet_count = (dictionary["retweet_count"] as? Int) ?? 0
        favorite_count = (dictionary["favorite_count"] as? Int) ?? 0
        
        let timestampString = dictionary["created_at"] as? String
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        
        if let timestampString = timestampString {
            tweet_created_at = formatter.date(from: timestampString)
        }
        let now = Date()

        timeInInt = Int(now.timeIntervalSince(tweet_created_at!))
        
        if timeInInt! >= 86400 {
            timeSince = String(timeInInt! / 86400)+"d"
        }
        if (3600..<86400).contains(timeInInt!) {
            timeSince = String(timeInInt!/3600)+"h"
        }
        if (60..<3600).contains(timeInInt!) {
            timeSince = String(timeInInt!/60)+"m"
        }
        if timeInInt! < 60 {
            timeSince = String(timeInInt!)+"s"
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        return tweets
        
    }
    
}
