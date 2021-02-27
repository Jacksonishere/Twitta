//
//  LoginViewController.swift
//  Twitter
//
//  Created by Jackson Lu on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if UserDefaults.standard.bool(forKey: "Loggedin"){
//            self.performSegue(withIdentifier: "loginToHome" , sender: self)
//        }
//    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "Loggedin"){
            self.performSegue(withIdentifier: "loginToHome" , sender: self)
        }
    }
    @IBAction func onLogin(_ sender: Any) {
        let myURL = "https://api.twitter.com/oauth/request_token"
        TwitterAPICaller.client?.login(url: myURL, success: {
            UserDefaults.standard.set(true, forKey: "Loggedin")
            self.performSegue(withIdentifier: "loginToHome" , sender: self)
        }, failure: {
            error in print("Couldn't sign in")
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
