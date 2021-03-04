//
//  TweetViewController.swift
//  Twitter
//
//  Created by Jackson Lu on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var myTweet: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTweet.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func tweet(_ sender: Any) {
        if(!myTweet.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: myTweet.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
