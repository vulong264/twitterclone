//
//  LoginController.swift
//  TwitterClone
//
//  Created by LVMBP on 3/1/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLogin(_ sender: UIButton) {
        
        TwitterClient.sharedInstance?.getRequestToken()
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
