//
//  SportCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lName: UILabel!
    
    func bind(sport: Sport) {
        ivImage.image = UIImage(named: sport.thumb)
        lName.text = sport.title
    }
}
