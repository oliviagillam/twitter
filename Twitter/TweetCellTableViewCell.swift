//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Olivia Gillam on 4/24/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var retweetButton: UIButton!
    var favorited:Bool = false
    //var retweeted:Bool = false
    var tweetID:Int = -1

    
    @IBAction func favTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if(toBeFavorited){
            TwitterAPICaller.client?.favoriteTweet(tweetID:tweetID, success: {
                self.setFavorite(true)

            }, failure: { (error) in
                print("favorite did not succeed: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetID:tweetID, success: {
                self.setFavorite(false)

            }, failure: { (error) in
                print("unfavorite did not succeed: \(error)")
            })
        }
    }
    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID,  success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Unable to retweet: \(error)")
        })
    }
    func setRetweeted(_ isRetweeted:Bool){
        if (isRetweeted){
            if #available(iOS 13.0, *) {
                retweetButton.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for:  UIControl.State.normal)
                retweetButton.isEnabled = false
            } else {
                // Fallback on earlier versions
            }
            
        }
        else{
            if #available(iOS 13.0, *) {
                retweetButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for:  UIControl.State.normal)
                retweetButton.isEnabled = true
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if( favorited) {
            if #available(iOS 13.0, *) {
                favButton.setImage(UIImage(systemName: "shift.fill"), for:  UIControl.State.normal)
            } else {
                // Fallback on earlier versions
            }
        }
        else{
            if #available(iOS 13.0, *) {
                favButton.setImage(UIImage(systemName: "shift"), for:  UIControl.State.normal)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        // Configure the view for the selected state
    }

}
