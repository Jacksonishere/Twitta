//
//  tweetCell.swift
//  Twitter
//
//  Created by Jackson Lu on 2/26/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class tweetCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetID:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setFavorite(_ isfavorited: Bool){
        favorited = isfavorited
        if(favorited){
            favButton.setImage(UIImage(named: "likefilled"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "like"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let favorite = !favorited
        if(favorite){
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Could not like")
            })
        }
        else{
            TwitterAPICaller.client?.destroyFavTweet(tweetID: tweetID, success: {
                self.setFavorite(false)
            }, failure: { (Error) in
                print("Could not like")
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any) {
    }
}
