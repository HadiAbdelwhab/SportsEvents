//
//  UpComingEventsCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import UIKit
import Kingfisher

class UpComingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var homeTeamImageView:UIImageView!
    @IBOutlet var awayTeamImageView:UIImageView!
    @IBOutlet var homeTeamLable:UILabel!
    @IBOutlet var awayTeamLable:UILabel!
    @IBOutlet var eventDateLable:UILabel!
    

    
    public func configure(homeTeam:String, awayTeam:String, homeLogo:String, awayLogo:String, eventDate:String){
            
            homeTeamLable.text = homeTeam
            awayTeamLable.text = awayTeam
            
            eventDateLable.text = eventDate
            
            homeTeamImageView.kf.setImage(with: URL(string: homeLogo))
            awayTeamImageView.kf.setImage(with: URL(string: awayLogo))

            
        }
}
