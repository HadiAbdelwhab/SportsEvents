//
//  TeamsCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 15/05/2024.
//

import UIKit
import Kingfisher

class TeamsCollectionViewCell: UICollectionViewCell {

    @IBOutlet var teamImageView:UIImageView!
    @IBOutlet var teamTitleLable:UILabel!
    
    
    public func config(teamTitle:String, teamImage:String){
        
        teamTitleLable.text = teamTitle
        teamImageView.kf.setImage(with: URL(string: teamImage))
        
    }
    
}
