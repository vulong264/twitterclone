//
//  User.swift
//  TwitterClone
//
//  Created by LVMBP on 3/3/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var tagline: String?
    var dictionary: NSDictionary
    static let userDidLogOutNotification = "UserDidLogOut"
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString{
            profileUrl = URL(string: profileUrlString)
        }
    }
    
    static var _currentUser: User?
    class var currentUser: User? {
        get{
            if _currentUser == nil {
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUser") as? Data
            
            if let userData = userData{
                let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as? NSDictionary
                
                _currentUser = User(dictionary: dictionary!)
            }
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                
                defaults.setValue(data, forKey: "currentUser")
            }
            else{
                defaults.setValue(nil, forKey: "currentUser")
            }
            defaults.synchronize()
        }
    }
}
