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
    
    
    
    public func config(teamLogo:String, teamName:String){
        
        
        TeamLogoImageView.kf.setImage(with: URL(string: teamLogo))
        teamTitle.text = teamName
       
        
    }
}
