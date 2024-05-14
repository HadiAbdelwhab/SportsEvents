//
//  LatestResultsCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 14/05/2024.
//

import UIKit

class LatestResultsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var homeTeamImageView:UIImageView!
    @IBOutlet var awayTeamImageView:UIImageView!
    @IBOutlet var homeTeamLable:UILabel!
    @IBOutlet var awayTeamLable:UILabel!
    @IBOutlet var resultLable:UILabel!
    @IBOutlet var eventDateLable:UILabel!

    
    public func configure(homeTeam:String, awayTeam:String, homeLogo:String, awayLogo:String, eventResult:String, eventDate:String){
            
            homeTeamLable.text = homeTeam
            awayTeamLable.text = awayTeam
            
        
            homeTeamImageView.kf.setImage(with: URL(string: homeLogo))
            awayTeamImageView.kf.setImage(with: URL(string: awayLogo))

            resultLable.text = eventResult
            eventDateLable.text = eventDate
        }
}
