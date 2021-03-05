//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Jackson Lu on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numofTweets: Int = 0
        
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweet()
    }
    
    // MARK: - Functions
    
    @objc func loadTweet(){
        numofTweets = 20;
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count" : 20]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() //everytime call this method to fetch new tweets, gonna have to reload tableview to say hey, ive just gotten new data. i need to refrehs.
            self.myRefreshControl.endRefreshing()
        }, failure: { (Error) in
            print("Couldn't get dicts")
        })
        
    }

    @objc func loadMoreTweets(){
        numofTweets += 20;
        let myURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count" : 10]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myURL, parameters: myParams, success: { (tweets: [NSDictionary]) in
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData() //everytime call this method to fetch new tweets, gonna have to reload tableview to say hey, ive just gotten new data. i need to refrehs.
        }, failure: { (Error) in
            print("Couldn't get dicts")
        })
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! tweetCell
        
        let userDict = tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.usernameLabel.text = userDict["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageURL = URL(string: (userDict["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data{
            cell.profileImageView.image = UIImage(data: imageData)
        }
        
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        return cell
    }
    
    // MARK: - Table view delegates
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweetArray.count{
            loadMoreTweets()
        }
    }
    
    
    // MARK: -Actions
    
    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        
        UserDefaults.standard.set(false, forKey: "Loggedin")
        self.dismiss(animated: true, completion: nil)
    }
    
}
