//
//  PlayerCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 15/05/2024.
//

import UIKit
import Kingfisher

class PlayerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerNameLable: UILabel!
    
    @IBOutlet weak var playerNumberLable: UILabel!
    @IBOutlet weak var playerRateLable: UILabel!
    @IBOutlet weak var playerAgeLable: UILabel!
    
    
    public func configure(playerImage: String?, playerName: String, playerNumber: String, playerRate: String, playerAge: String) {
        if let imageURLString = playerImage, let imageURL = URL(string: imageURLString) {
            playerImageView.kf.setImage(with: imageURL)
        } else {
            
            playerImageView.image = UIImage(named: "placeholderImage")
        }
        
        playerNameLable.text = playerName
        playerNumberLable.text = playerNumber
        playerRateLable.text = playerRate
        playerAgeLable.text = playerAge
    }

    
}
