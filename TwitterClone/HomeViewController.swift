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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        TwitterClient.sharedInstance?.getTweets()
        // Do any additional setup after loading the view.
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterViewCell") as! TweetViewCell
        return cell
    }
}
