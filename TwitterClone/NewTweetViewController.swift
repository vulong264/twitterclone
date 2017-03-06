//
//  NewTweetViewController.swift
//  TwitterClone
//
//  Created by LVMBP on 3/3/17.
//  Copyright © 2017 vulong. All rights reserved.
//

import UIKit

class NewTweetViewController: UIViewController {
    let limitLength = 140
    @IBOutlet weak var textView: UITextView!
    @IBAction func onEditingChanged(_ sender: UITextField) {
        var fullText = sender.text ?? ""
        let charLeft = limitLength - Int((fullText.characters.count) )
//        print(charLeft)
        charCountLabel.title = String(charLeft)
    }
    @IBOutlet weak var charCountLabel: UIBarButtonItem!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var avatarImg: UIImageView!
    
    @IBOutlet weak var tweetTtField: UITextField!

    @IBAction func postTweet(_ sender: UIBarButtonItem) {
        let newTweet = tweetTtField.text
        if newTweet != "" {
            TwitterClient.sharedInstance?.postTweet(tweet: newTweet, success: { (tweet: Tweet) in
            
            }, failure: { (error: Error) in
                print("\(error.localizedDescription)")
            })
        }
    }
    
    @IBAction func onCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if (User.currentUser?.profileUrl != nil) {
            avatarImg.setImageWith((User.currentUser?.profileUrl)!)
        }
        accountLabel.text = User.currentUser?.screenname
        NameLabel.text = User.currentUser?.name
        tweetTtField.delegate = self
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
extension NewTweetViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = tweetTtField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= limitLength
    }
}
