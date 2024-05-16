//
//  TeamCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 15/05/2024.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var TeamLogoImageView: UIImageView!
    
    @IBOutlet weak var teamTitle: UILabel!
    @IBOutlet weak var teamCoachLable: UILabel!
    @IBOutlet weak var teamCaptainLable: UILabel!
    
    
    public func config(teamLogo:String, teamName:String, teamCoach:String, teamCaptain:String){
        
        
        TeamLogoImageView.kf.setImage(with: URL(string: teamLogo))
        teamTitle.text = teamName
        teamCoachLable.text = teamCoach
        teamCaptainLable.text = teamCaptain
        
        
    }
}
